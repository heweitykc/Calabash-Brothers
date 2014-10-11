package com.game.chestbox.message
{
    import __AS3__.vec.*;
    import com.game.chestbox.bean.*;
    import net.*;

    public class ResChestBoxNewGridInfoToClientMessage extends Message
    {
        private var _newingridlist:Vector.<ChestGridInfo>;
        private var _newoutgridlist:Vector.<ChestGridInfo>;

        public function ResChestBoxNewGridInfoToClientMessage()
        {
            this._newingridlist = new Vector.<ChestGridInfo>;
            this._newoutgridlist = new Vector.<ChestGridInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._newingridlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._newingridlist.length)
            {
                
                writeBean(this._newingridlist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._newoutgridlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._newoutgridlist.length)
            {
                
                writeBean(this._newoutgridlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._newingridlist[_loc_1] = readBean(ChestGridInfo) as ChestGridInfo;
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._newoutgridlist[_loc_1] = readBean(ChestGridInfo) as ChestGridInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 156103;
        }// end function

        public function get newingridlist() : Vector.<ChestGridInfo>
        {
            return this._newingridlist;
        }// end function

        public function set newingridlist(param1:Vector.<ChestGridInfo>) : void
        {
            this._newingridlist = param1;
            return;
        }// end function

        public function get newoutgridlist() : Vector.<ChestGridInfo>
        {
            return this._newoutgridlist;
        }// end function

        public function set newoutgridlist(param1:Vector.<ChestGridInfo>) : void
        {
            this._newoutgridlist = param1;
            return;
        }// end function

    }
}
