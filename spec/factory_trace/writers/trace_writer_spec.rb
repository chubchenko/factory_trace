RSpec.describe FactoryTrace::Writers::TraceWriter do
  subject(:printer) { described_class.new(output) }

  describe '#print' do
    let(:output) { StringIO.new }
    let(:defined) do
      FactoryTrace::Structures::Collection.new(
        [
          FactoryTrace::Structures::Factory.new('user', nil, ['with_phone'], [])
        ],
        [
          FactoryTrace::Structures::Trait.new('with_address', nil)
        ]
      )
    end

    let(:used) do
      FactoryTrace::Structures::Collection.new({}, {})
    end

    it 'prints the result' do
      printer.write(defined, used)

      expect(output.string).to eq(<<~TEXT)
      {
        "defined": {
          "factories": [
            {
              "name": "user",
              "parent_name": null,
              "trait_names": [
                "with_phone"
              ],
              "alias_names": [

              ]
            }
          ],
          "traits": [
            {
              "name": "with_address",
              "owner_name": null
            }
          ]
        },
        "used": {
          "factories": [

          ],
          "traits": [

          ]
        }
      }
      TEXT
    end
  end
end
