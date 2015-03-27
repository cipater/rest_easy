require 'spec_helper'

describe ProductsController, :type => :controller do
  let(:params)   { { id: "1" } }
  let(:product)  { Product.new 1 }
  let(:products) { [ Product.new(1), Product.new(2) ] }

  before do
    allow(Product).to receive(:find_by).with(id: params[:id]).and_return product
    allow(Product).to receive(:find_by!).with(id: params[:id]).and_return product
    allow(Product).to receive(:all).and_return products
    allow_any_instance_of(ProductsController).to receive(:render).and_return nil
    # ProductsController.any_instance.stub(:render)
  end

  it "provides #products for index requests" do
    get :index
    binding.pry
    expect(subject.products).to eq(products)
  end

  describe "#new" do
    let(:product)  { Product.new }
    before         { allow(Product).to receive(:new).and_return product }

    it "sets @product" do
      expect(Product).to receive(:new).and_return product
      get :new
      expect(assigns(:product)).to eq(product)
      expect(subject.product).to eq(product)
    end
  end

  describe "#show" do
    it "sets @product" do
      get :show, id: product.id
      expect(assigns(:product)).to eq(product)
      expect(subject.product).to eq(product)
    end
  end

  describe '#edit' do
    it "sets @product" do
      get :edit, id: product.id

      expect(assigns(:product)).to eq(product)
      expect(subject.product).to eq(product)
    end
  end

end
