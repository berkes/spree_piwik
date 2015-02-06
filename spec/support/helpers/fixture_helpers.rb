module FixtureHelpers
  def fixture(filename)
    File.read(File.join(fixture_path, filename)).strip
  end
end
