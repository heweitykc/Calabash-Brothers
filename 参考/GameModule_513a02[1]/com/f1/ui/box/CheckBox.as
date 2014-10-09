package com.f1.ui.box
{
    import com.f1.ui.*;
    import flash.events.*;
    import flash.text.*;

    public class CheckBox extends Component
    {

        public function CheckBox(param1 = null)
        {
            super(param1);
            display.gotoAndStop(1);
            display.addEventListener(MouseEvent.CLICK, this.onBoxClickHandle);
            return;
        }// end function

        private function onBoxClickHandle(event:MouseEvent) : void
        {
            event.stopImmediatePropagation();
            this.selected = !this.selected;
            this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        public function bindTextField(param1:TextField) : void
        {
            param1.addEventListener(MouseEvent.CLICK, this.onBoxClickHandle);
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            display.selected = param1;
            if (display.selected)
            {
                display.gotoAndStop(3);
                this.dispatchEvent(new Event(Event.SELECT));
            }
            else
            {
                display.gotoAndStop(1);
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return display.selected;
        }// end function

        public static function group(... args) : void
        {
            args = new activation;
            var list:Array;
            var radio:CheckBox;
            var onRadioClickHandle:Function;
            var onRadioSelectHandle:Function;
            var args:* = args;
            onRadioClickHandle = function (event:MouseEvent) : void
            {
                var _loc_2:* = 0;
                while (_loc_2 < list.length)
                {
                    
                    radio = list[_loc_2];
                    radio.selected = false;
                    _loc_2++;
                }
                radio = event.currentTarget as ;
                radio.display.gotoAndStop(3);
                radio.display.selected = true;
                return;
            }// end function
            ;
            onRadioSelectHandle = function (event:Event) : void
            {
                var _loc_2:* = event.currentTarget as ;
                var _loc_3:* = 0;
                while (_loc_3 < list.length)
                {
                    
                    radio = list[_loc_3];
                    if (radio != _loc_2)
                    {
                        radio.selected = false;
                    }
                    _loc_3++;
                }
                return;
            }// end function
            ;
            list = ;
            var i:int;
            while ( < CheckBox.length)
            {
                
                radio = CheckBox[];
                CheckBox.selected =  == 0;
                CheckBox.addEventListener(MouseEvent.CLICK, );
                CheckBox.addEventListener(Event.SELECT, );
                i = ( + 1);
            }
            return;
        }// end function

    }
}
