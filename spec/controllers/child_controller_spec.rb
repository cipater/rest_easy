require 'spec_helper'

describe ChildsController, :type => :controller do
  let(:params)   { { id: "1" } }
  let(:child)  { Child.new 1 }
  let(:childs) { [ Child.new(1), Child.new(2) ] }

  before do
    allow(Child).to receive(:find_by).with(id: params[:id]).and_return child
    allow(Child).to receive(:find_by!).with(id: params[:id]).and_return child
    allow(Child).to receive(:all).and_return childs
    allow_any_instance_of(ChildsController).to receive(:render).and_return nil
    # childsController.any_instance.stub(:render)
  end

  describe "As a sub-classed controller" do
    it "provides #childs for index requests" do
      get :index
      expect(subject.childs).to eq(childs)
    end
  end

end
