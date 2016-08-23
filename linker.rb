
require 'colorize'

if ! ARGV[0] or ! ARGV[1]

	puts "Usage"
	puts "ruby #{$0} <hashes file> <cracked file>"
	exit

else

	hashed = {}

	infile = ARGV[0]

	File.open(infile,'r') {|file|
		file.each do |l|
			split = l.strip.split(':')

			next if split == []

			hash = split[3]
			username = split[0].downcase

			if ! hashed[hash]
				hashed[hash] = [username]
			else
				hashed[hash] << username
			end

		end
	}

	cracked = {}

	infile = ARGV[1]

	File.open(infile, 'r') {|file|
		file.each do |l| 
			split = l.strip.split(':')

			next if split == []
			
			split[1] = '<< BLANK / NO PASSWORD >>' if ! split[1]

			hash = split[0]
			password = split[1]

			puts password.green() + ": " + hashed[hash].join(', ')
		end
	}

end
