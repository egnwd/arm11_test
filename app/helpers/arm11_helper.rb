module Arm11Helper

  def codeDelim
    return "#{start_span("code-delim")}$#{end_span}".html_safe
  end
  def outputDelim
    return "#{start_span("output-delim")}>#{end_span}".html_safe
  end
  def pass
    return "#{start_span("code-tick")}Pass#{end_span}".html_safe
  end
  def fail
    return "#{start_span("code-cross")}Fail#{end_span}".html_safe
  end
  def fileName(file)
    return /([a-z_]+([0-9]{1,2})?)\.s/.match(file)[1]
  end
  def outputAssemble(fileName)
    out = `diff tmp/outputs/#{fileName} ../arm11_1415_testsuite/test_cases/#{fileName}`
    return "Assemble: " + output(out, true)
  end
  def outputEmulate(fileName)
    out = `diff tmp/outputs/#{fileName}.out ../arm11_1415_testsuite/test_cases/#{fileName}.out`
    return "Emulate:  " + output(out, false)
  end
  def output(out, isAssemble)
    $total+= 0.5
    if out == ""
      if isAssemble
        $passA += 1
      else
        $passE += 1
      end
      return pass()
    else
      return fail()
    end
  end
  def progressBar
    outputStr = ''
    percents = ''
    bar = ''

    # percents
    percents << "Assemble: #{$passA}/%d, Emulate: #{$passE}/%d" %[$total, $total]

    # bar
    green  = [$passA, $passE].min
    orange = ($passA - $passE).abs
    red    = $total - [$passA, $passE].max

    bar << "["
    bar << start_span("green")
    bar << "+" * green
    bar << end_span
    bar << start_span("orange")
    bar << "*" * orange
    bar << end_span
    bar << start_span("red")
    bar << "-" * red
    bar << end_span
    bar << "]"

    outputStr << percents
    outputStr << "<br />    "
    outputStr << bar

    return outputStr.html_safe
  end
  def start_span(class_name)
    return "<span class=\"#{class_name}\">"
  end
  def end_span
    return "</span>"
  end
end
