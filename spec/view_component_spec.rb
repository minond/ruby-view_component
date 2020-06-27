describe ViewComponent do
  it "has a version number" do
    expect(ViewComponent::VERSION).not_to be nil
  end

  describe "variable components" do
    it "renders a component" do
      expect(VariableComponent.render).to eq %(<span class="header">hi</span>)
    end

    it "accepts props" do
      expect(VariableComponent.render(:label => "hello")).to eq %(<span class="header">hello</span>)
    end
  end

  describe "class components" do
    it "renders a component" do
      expect(ClassComponent.render.strip).to eq %(<span>hi</span>)
    end

    it "accepts props" do
      expect(ClassComponent.render(:label => "hello").strip).to eq %(<span>hello</span>)
    end
  end

  describe "type checking" do
    it "accepts props of correct type" do
      expect { TypedComponent.render(:s => "", :b => true) }.not_to raise_error
    end

    it "accepts props of correct type when the type is a compound type" do
      expect { TypedComponent.render(:s => "") }.not_to raise_error
      expect { TypedComponent.render(:s => "", :b => nil) }.not_to raise_error
      expect { TypedComponent.render(:s => "", :b => false) }.not_to raise_error
      expect { TypedComponent.render(:s => "", :b => true) }.not_to raise_error
    end

    it "raises an exception when a prop type is not correct" do
      expect { TypedComponent.render(:s => 123) }.to raise_error(ViewComponent::TypeError)
    end
  end
end
