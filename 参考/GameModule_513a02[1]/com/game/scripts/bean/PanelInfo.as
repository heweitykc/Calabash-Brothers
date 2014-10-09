package com.game.scripts.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class PanelInfo extends Bean
    {
        private var _panelmap:String;
        private var _buttoninfolist:Vector.<ButtonInfo>;
        private var _paneltxtinfolist:Vector.<PanelTxtInfo>;
        private var _paneliteminfolist:Vector.<PanelItemInfo>;

        public function PanelInfo()
        {
            this._buttoninfolist = new Vector.<ButtonInfo>;
            this._paneltxtinfolist = new Vector.<PanelTxtInfo>;
            this._paneliteminfolist = new Vector.<PanelItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeString(this._panelmap);
            writeShort(this._buttoninfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._buttoninfolist.length)
            {
                
                writeBean(this._buttoninfolist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._paneltxtinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._paneltxtinfolist.length)
            {
                
                writeBean(this._paneltxtinfolist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._paneliteminfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._paneliteminfolist.length)
            {
                
                writeBean(this._paneliteminfolist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._panelmap = readString();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._buttoninfolist[_loc_2] = readBean(ButtonInfo) as ButtonInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._paneltxtinfolist[_loc_2] = readBean(PanelTxtInfo) as PanelTxtInfo;
                _loc_2++;
            }
            var _loc_4:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                this._paneliteminfolist[_loc_2] = readBean(PanelItemInfo) as PanelItemInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get panelmap() : String
        {
            return this._panelmap;
        }// end function

        public function set panelmap(param1:String) : void
        {
            this._panelmap = param1;
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

        public function get paneltxtinfolist() : Vector.<PanelTxtInfo>
        {
            return this._paneltxtinfolist;
        }// end function

        public function set paneltxtinfolist(param1:Vector.<PanelTxtInfo>) : void
        {
            this._paneltxtinfolist = param1;
            return;
        }// end function

        public function get paneliteminfolist() : Vector.<PanelItemInfo>
        {
            return this._paneliteminfolist;
        }// end function

        public function set paneliteminfolist(param1:Vector.<PanelItemInfo>) : void
        {
            this._paneliteminfolist = param1;
            return;
        }// end function

    }
}
