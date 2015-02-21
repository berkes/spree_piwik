module FixtureHelpers
  def fixture(filename)
    parser.parse(File.read(File.join(fixture_path, filename))).to_ecma
  end

  private

  def parser
    @parser ||= RKelly::Parser.new
  end
end
