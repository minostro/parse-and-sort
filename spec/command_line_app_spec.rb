require_relative '../command_line_app'

RSpec.describe CommandLineApp, "#main" do
  context "with data from file" do
    let(:data) {
      """
      Inostroza,Milton,Male,Blue,04/08/1983\n
      Inostroza,Milton2,Female,Black,04/08/1985
      """
    }
    let(:expected_data) {
      """Output 1:
==================================================
Inostroza,Milton2,Female,Black,8/4/1985
Inostroza,Milton,Male,Blue,8/4/1983
==================================================
Output 2:
==================================================
Inostroza,Milton,Male,Blue,8/4/1983
Inostroza,Milton2,Female,Black,8/4/1985
==================================================
Output 3:
==================================================
Inostroza,Milton,Male,Blue,8/4/1983
Inostroza,Milton2,Female,Black,8/4/1985
==================================================
"""
    }
    it "prints results in the standard output" do
      tmp_file = "/tmp/test-file"
      File.write(tmp_file, data)
      expect {
        CommandLineApp.main("test", ",")
      }.to output(expected_data).to_stdout
    end
  end
end
