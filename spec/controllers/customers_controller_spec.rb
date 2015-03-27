require 'spec_helper'

class CustomerDecorator
  class << self
    def decorate customer
      new customer
    end

    def decorate_collection customers
      customers.collect do |customer|
        new customer
      end
    end
  end

  attr_reader :model

  def initialize customer
    @model = customer
  end
end

describe CustomersController do
  let(:params)    { { id: "1" } }
  let(:customer)  { Customer.new(1) }
  let(:customers) { [ Customer.new(1), Customer.new(2) ] }
  let(:decorated_customers) { CustomerDecorator.decorate_collection(customers) }

  before do
    Customer.stub(:find_by).with(id: params[:id]).and_return customer
    Customer.stub(:find_by!).with(id: params[:id]).and_return customer
    Customer.stub(:all).and_return customers
    CustomersController.any_instance.stub(:render)
    RestEasy.configure do |config|
      config.decorator_interface_class = RestEasy::DecoratorInterfaces::Draper
    end
  end

  it "decorates Customer" do
    get :show, id: customer.id
    expect(subject.customer).to be_a(CustomerDecorator)
  end

  it "decorates Customers" do
    get :index
    expect(subject.customers.first).to be_a(CustomerDecorator)
  end

  it "provides #undecorated_customer" do
    get :show, id: customer.id
    expect(subject.undecorated_customer).to eq(customer)
  end

  it "provides #undecorated_customers" do
    get :index
    expect(subject.undecorated_customers).to eq(customers)
  end

end
