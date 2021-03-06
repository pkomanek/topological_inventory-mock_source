describe TopologicalInventory::MockSource::Storage do
  let(:server) do
    TopologicalInventory::MockSource::Server.new
  end

  before do
    @storage = described_class.new(server)
  end

  context "#entity types" do
    before do
      @entity_types = %i(entity1 entity2)

      allow(@storage).to receive(:entity_types).and_return(@entity_types)

      allow_any_instance_of(TopologicalInventory::MockSource::EntityType).to receive(:entity_class).and_return(nil)
    end

    it "creates entity types based on list" do
      @storage.create_entities

      @entity_types.each do |key|
        expect(@storage.entities).to have_key(key)
      end
    end

    it "access entity types by method missing" do
      @storage.create_entities

      expect(@storage.entity1).to be_kind_of(TopologicalInventory::MockSource::EntityType)
      expect(@storage.respond_to?(:entity3)).to eq(false)
    end
  end
end
