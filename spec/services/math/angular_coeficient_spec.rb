RSpec.describe Math::AngularCoeficient do
  describe "Service Angular Coeficient" do
    let(:data) { [1, 4, 6, 5, 4, 3, 5, 6, 7] }
    it "should return angular coeficient" do
      service = described_class.new(data)
      expect(service.call).to eq(0.43333333333333335)
    end
  end
end