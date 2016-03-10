#!/usr/bin/ruby
# coding: utf-8-with-signature

require 'gtk2'
load '2048.rb'
load 'cell_color.rb'

win = Gtk::Window.new()
win.signal_connect("destroy") do
	Gtk.main_quit()
end
win.set_default_size(300,300)
tbl = Gtk::Table.new(4, 4, true)
opeLabel = ::Gtk::Label.new("←:A  ↑:W  →:D  ↓:S")
tbl.attach_defaults(opeLabel, 0, 4, 4, 5)
set_field

i = 0
0.upto(3){|y|
	0.upto(3){|x|
		field_cell = $field[y][x]
		eval("@btn#{i} = Gtk::Label.new('#{field_cell}')")
		eval("tbl.attach_defaults(@btn#{i}, x, x+1, y, y+1)")
		set_cell_color(field_cell, i)

		i += 1
	}
}
btn_reset = Gtk::Button.new("RESET")
tbl.attach_defaults(btn_reset, 0, 4, 5, 6)
btn_reset.signal_connect("clicked") do |b|
	set_field
	i = 0
	0.upto(3){|y|
		0.upto(3){|x|
			field_cell = $field[y][x]
			eval("@btn#{i}.set_label('#{field_cell}')")

			set_cell_color(field_cell, i)
            
			i += 1
		}
	}

end

win.signal_connect("key_press_event") do |wdt, evt|
	field_bk = $field.map(&:dup)
	if Gdk::Keyval.to_name(evt.keyval) == "a"
		move_left2
	elsif Gdk::Keyval.to_name(evt.keyval) == "d"
		move_right2
	elsif Gdk::Keyval.to_name(evt.keyval) == "s"
		move_under2 #なんでdownじゃないねん
	elsif Gdk::Keyval.to_name(evt.keyval) == "w"
		move_up2
	elsif Gdk::Keyval.to_name(evt.keyval) == "0"
	else
	end
    x, y = find_zero

    if($field.max.max >= 2048)
      opeLabel.set_label("2048達成！")
    end
	if field_bk == $field
	else
#	p field_bk
#	p $field
	    $field[x][y] = [2, 4].sample
	end

	i = 0
	0.upto(3){|y|
		0.upto(3){|x|
			field_cell = $field[y][x]
			eval("@btn#{i}.set_label('#{field_cell}')")
			set_cell_color(field_cell, i)

			i += 1
		}
	}

end

win.add(tbl)
win.show_all()
Gtk.main()
