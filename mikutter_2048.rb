# -*- coding: utf-8 -*-
#ダークマターをロードする
require File.join(File.dirname(__FILE__), '2048.rb')
require File.join(File.dirname(__FILE__), 'cell_color.rb')

Plugin.create :m2048 do

  command(:m2048,
          name: '2048を遊ぶ',
          condition: lambda{ |opt| true },
          visible: true,
          role: :postbox
         ) do |opt|

    tab :m2048, "2048" do
      set_deletable true
      temporary_tab

      over_2048 = false
      tbl = ::Gtk::Table.new(4, 4, true)
      opeLabel = ::Gtk::Label.new("←:A  ↑:W  →:D  ↓:S")
      tbl.attach_defaults(opeLabel, 0, 4, 4, 5)
      btn_reset = ::Gtk::Button.new("RESET")
      tbl.attach_defaults(btn_reset, 0, 4, 5, 6)
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
        over_2048 = false
      end

      tbl.signal_connect("key_press_event") do |wdt, evt|
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

        if($field.max.max >= 2048 && over_2048 == false)
          Plugin.call(:update, nil, [Message.new(:message => "2048達成！おめでとう！", :system => true)])
          over_2048 = true
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
      #なんかよーわからんけどこうしたらタブに追加できるねんな
      nativewidget Plugin::Console::ConsoleControl.new().
                    pack1(::Gtk::Table.new(2, 3).
                           attach(tbl, 0, 1, 0, 1, ::Gtk::FILL|::Gtk::SHRINK|::Gtk::EXPAND, ::Gtk::FILL|::Gtk::SHRINK|::Gtk::EXPAND),
                          true, false)
      active!
    end



  end
end
