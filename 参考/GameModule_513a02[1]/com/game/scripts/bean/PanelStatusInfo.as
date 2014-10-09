package com.game.scripts.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class PanelStatusInfo extends Bean
    {
        private var _panelname:String;
        private var _type:int;
        private var _buttoninfolist:Vector.<ButtonInfo>;

        public function PanelStatusInfo()
        {
            this._buttoninfolist = new Vector.<ButtonInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._panelname);
            writeByte(this._type);
            writeShort(this._buttoninfolist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._buttoninfolist.length)
            {
                
                writeBean(this._buttoninfolist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._panelname = readString();
            this._type = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._buttoninfolist[_loc_2] = readBean(ButtonInfo) as ButtonInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get panelname() : String
        {
            return this._panelname;
        }// end function

        public function set panelname(param1:String) : void
        {
            this._panelname = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get buttoninfolist() : Vector.<ButtonInfo>
        {
            return this._buttoninfolist;
        }// end function

        public function set buttoninfolist(param1:Vector.<ButtonInfo>) : void
        {
            this._buttoninfolist = param1;
            return;
        }// end function

    }
}
