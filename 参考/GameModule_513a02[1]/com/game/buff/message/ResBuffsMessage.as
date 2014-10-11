package com.game.buff.message
{
    import __AS3__.vec.*;
    import com.game.buff.bean.*;
    import net.*;

    public class ResBuffsMessage extends Message
    {
        private var _fightState:int;
        private var _buff:Vector.<CSBuffInfo>;

        public function ResBuffsMessage()
        {
            this._buff = new Vector.<CSBuffInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._fightState);
            writeShort(this._buff.length);
            _loc_1 = 0;
            while (_loc_1 < this._buff.length)
            {
                
                writeBean(this._buff[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._fightState = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._buff[_loc_1] = readBean(CSBuffInfo) as CSBuffInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 113101;
        }// end function

        public function get fightState() : int
        {
            return this._fightState;
        }// end function

        public function set fightState(param1:int) : void
        {
            this._fightState = param1;
            return;
        }// end function

        public function get buff() : Vector.<CSBuffInfo>
        {
            return this._buff;
        }// end function

        public function set buff(param1:Vector.<CSBuffInfo>) : void
        {
            this._buff = param1;
            return;
        }// end function

    }
}
