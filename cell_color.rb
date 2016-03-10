def set_cell_color(cell_num, i)
	if cell_num == 2
		eval("@btn#{i}.markup = %Q[<span background=\"#FFA500\" size=\"xx-large\">  2  </span>]")
	elsif cell_num == 4
		eval("@btn#{i}.markup = %Q[<span background=\"#FF8C00\" size=\"xx-large\">  4  </span>]")
	elsif cell_num == 8
		eval("@btn#{i}.markup = %Q[<span background=\"#FF4500\" size=\"xx-large\">  8  </span>]")
	elsif cell_num == 16
		eval("@btn#{i}.markup = %Q[<span background=\"#FF6347\" size=\"xx-large\">  16  </span>]")
	elsif cell_num == 32
		eval("@btn#{i}.markup = %Q[<span background=\"#FF7F50\" size=\"xx-large\">  32  </span>]")
	elsif cell_num == 64
		eval("@btn#{i}.markup = %Q[<span background=\"#FFA07A\" size=\"xx-large\">  64  </span>]")
	elsif cell_num == 128
		eval("@btn#{i}.markup = %Q[<span background=\"#E9967A\" size=\"xx-large\">  128  </span>]")
	elsif cell_num == 256
		eval("@btn#{i}.markup = %Q[<span background=\"#FA8072\" size=\"xx-large\">  256  </span>]")
	elsif cell_num == 512
		eval("@btn#{i}.markup = %Q[<span background=\"#F08080\" size=\"xx-large\">  512  </span>]")
	elsif cell_num == 1024
		eval("@btn#{i}.markup = %Q[<span background=\"#CD5C5C\" size=\"xx-large\">  1024  </span>]")
	elsif cell_num >= 2048
		eval("@btn#{i}.markup = %Q[<span foreground=\"#FFFFFF\" background=\"#FF00FF\" size=\"xx-large\">  #{cell_num}  </span>]")
	end
end
