# LaKour Programming Language Compiler

class Compiler

  def initialize(path)
    @file = File.open(path, "r")

    name = path.split(".")

    @output = File.new(name[0] + ".rb", "w")
  end

  def compile

    token = ""

    isCommand = false

    @file.each_line do |line|

      for i in 0...line.length
        token += line[i].to_s

        token.gsub!("\n", "")
        token.sub!("  ", "")
        token.sub!("\t", "")

        if token == "gard'pa ou "

          lineToWrite = line.gsub("gard'pa ou ", "# ")

          @output << lineToWrite

          token = ""
          isCommand = true
          break
        end

        if token.include?("razout") or token.include?("enlev") or token.include?("miltipli") or token.include?("diviz")
          if token.include?("razout")
            lineToWrite = line.gsub("razout", "+=")
          elsif token.include?("enlev")
            lineToWrite = line.gsub("enlev", "-=")
          elsif token.include?("miltipli")
            lineToWrite = line.gsub("miltipli", "*=")
          elsif token.include?("diviz")
            lineToWrite = line.gsub("diviz", "/=")
          end


          @output << lineToWrite

          isCommand = true
          break
        end

        if line.include?("modile")
          line.gsub!("modile", "module")
        end

        if line.include?("menter")
          line.gsub!("menter", "false")
        elsif line.include?("vre")
          line.gsub!("vre", "true")
        end

        if line.include?("apele ") # Else check for function calling
          line.gsub!("apele ", "")
        end

        if line.include?("debut(")
          line.gsub!("debut(", "def initialize(")
        end


        if line.include?("nouvo")
          line.gsub!("nouvo", "new")
        end


        if token == "genn "

          lineToWrite = line.gsub("genn ", "require ")

          isCommand = true

          @output << lineToWrite

          token = ""
          break

        end

        if token == "zobjet "

          lineToWrite = line.gsub("zobjet ", "class ")

          if lineToWrite.include?(" ti ")
            lineToWrite.gsub!(" ti ", " < ")
          end

          isCommand = true

          @output << lineToWrite

          token = ""
          break

        end

        if token == "siper"

          lineToWrite = line.gsub("siper", "super")

          isCommand = true

          @output << lineToWrite

          token = ""
          break

        end

        if token == "pou "

          lineToWrite = line.gsub("pou ", "for ")
          lineToWrite = lineToWrite.gsub("dan", "in")
          lineToWrite = lineToWrite.gsub("ziska", "..")
          lineToWrite = lineToWrite.gsub("ben", "")

          isCommand = true

          @output << lineToWrite

          token = ""
          break
        end


        if token == "mi veu"
          # Line to write
          lineToWrite = line.gsub("mi veu ", "")

          isCommand = true

          @output << lineToWrite

          # End
          token = ""

          break
        end

        if token == "dit a li "
          # Line to write

          if line.include?("ek")
            lineToWrite = line.gsub("dit a li ", "")
            lineToWrite = lineToWrite.gsub("ek", "+")


              locToken = lineToWrite.split("+")

              locLine = ""
              for i in 0...locToken.length
                if i != locToken.length - 1
                  if token != 0
                    locLine += locToken[i] + ".to_s +"
                  else
                    locLine += "+" + locToken[i] + ".to_s"
                  end
                else
                  locToken[i].gsub!("\n", "")
                  locLine += locToken[i] + ".to_s\n"
                  #p locLine[i]
                end
              end

            lineToWrite = "puts " + locLine
          else
            lineToWrite = line.gsub("dit a li ", "puts ")
          end

          isCommand = true

          @output << lineToWrite

          token = ""
          break
        end

        if token == "si " or token == "tanqu\'"
          if token == "si "
            lineToWrite = line.gsub("si ", "if ")
          else
            lineToWrite = line.gsub("tanqu\' ", "while ")
          end

          lineToWrite = lineToWrite.gsub("le pa =", "!=")

          lineToWrite = lineToWrite.gsub("le =", "==")

          lineToWrite = lineToWrite.gsub("plus gran =", ">=")
          lineToWrite = lineToWrite.gsub("plus gran", ">")

          lineToWrite = lineToWrite.gsub("mouin gran =", "<=")
          lineToWrite = lineToWrite.gsub("mouin gran", "<")

          lineToWrite = lineToWrite.gsub("ben", "")
          lineToWrite = lineToWrite.gsub("\n", "")
          lineToWrite += "\n"

          isCommand = true

          @output << lineToWrite

          token = ""

          break
        end

        if token == "le fini"
          lineToWrite = "end\n"

          @output << lineToWrite

          isCommand = true

          token = ""
          break
        end

        if token == "case "
          lineToWrite = line.gsub("case ", "def ")

          @output << lineToWrite

          isCommand = true

          token = ""
          break
        end

        if token == "apele "

          lineToWrite = line.gsub("apele ", "")

          @output << lineToWrite

          isCommand = true

          token = ""
          break
        end

        if token == "sort "
          lineToWrite = line.gsub("sort ", "return ")

          @output << lineToWrite

          isCommand = true

          token = ""
          break
        end

      end

      if !isCommand
        @output << line
      end
      isCommand = false
      token = ""
    end
  end

end

puts "Compile what ?"
input = gets.chomp
Compiler.new(input.to_s).compile
