module Arm11Helper
  def codeDelim
    return "<span class=\"code-delim\">$</span>".html_safe
  end
  def outputDelim
    return "<span class=\"output-delim\">></span>".html_safe
  end
  def pass
    return "<span class=\"code-tick\">Pass</span>".html_safe
  end
  def fail
    return "<span class=\"code-cross\">Fail</span>".html_safe
  end
  def fileName(file)
    return /([a-z_]+([0-9]{1,2})?)\.s/.match(file)[1]
  end
  def output(fileName)
    out = `diff -q tmp/outputs/#{fileName} ../arm11_1415_testsuite/test_cases/#{fileName}`
    if out == ""
      return pass()
    else
      return fail()
    end
  end
end
