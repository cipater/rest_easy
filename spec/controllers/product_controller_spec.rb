require 'spec_helper'

describe ProductsController do
  let(:params)   { { id: "1" } }
  let(:product)  { Product.new 1 }
  let(:products) { [ Product.new(1), Product.new(2) ] }

  before do
    Product.stub(:find_by).with(id: params[:id]).and_return product
    Product.stub(:find_by!).with(id: params[:id]).and_return product
    Product.stub(:all).and_return products
    ProductsController.any_instance.stub(:render)
  end

  it "provides #products for index requests" do
    get :index
    expect(subject.products).to eq(products)
  end

  describe "#new" do
    let(:product)  { Product.new }
    before         { Product.stub(:new).and_return product }

    it "sets @product" do
      Product.should_receive(:new).and_return product
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
