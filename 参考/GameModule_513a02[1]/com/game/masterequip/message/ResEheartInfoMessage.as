package com.game.masterequip.message
{
    import __AS3__.vec.*;
    import com.game.masterequip.bean.*;
    import net.*;

    public class ResEheartInfoMessage extends Message
    {
        private var _type:int;
        private var _info:Vector.<EheartInfo>;

        public function ResEheartInfoMessage()
        {
            this._info = new Vector.<EheartInfo>;
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set info(param1:Vector.<EheartInfo>) : void
        {
            this._info = param1;
            return;
        }// end function

        public function get info() : Vector.<EheartInfo>
        {
            return this._info;
        }// end function

        override public function getId() : int
        {
            return 600041;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeShort(this._info.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._info.length)
            {
                
                writeBean(this._info[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._info[_loc_2] = readBean(EheartInfo) as EheartInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
