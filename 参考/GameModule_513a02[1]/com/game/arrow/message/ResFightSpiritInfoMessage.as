package com.game.arrow.message
{
    import __AS3__.vec.*;
    import com.game.arrow.bean.*;
    import net.*;

    public class ResFightSpiritInfoMessage extends Message
    {
        private var _notifytype:int;
        private var _fightspiritList:Vector.<FightSpiritInfo>;

        public function ResFightSpiritInfoMessage()
        {
            this._fightspiritList = new Vector.<FightSpiritInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._notifytype);
            writeShort(this._fightspiritList.length);
            _loc_1 = 0;
            while (_loc_1 < this._fightspiritList.length)
            {
                
                writeBean(this._fightspiritList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._notifytype = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._fightspiritList[_loc_1] = readBean(FightSpiritInfo) as FightSpiritInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 151104;
        }// end function

        public function get notifytype() : int
        {
            return this._notifytype;
        }// end function

        public function set notifytype(param1:int) : void
        {
            this._notifytype = param1;
            return;
        }// end function

        public function get fightspiritList() : Vector.<FightSpiritInfo>
        {
            return this._fightspiritList;
        }// end function

        public function set fightspiritList(param1:Vector.<FightSpiritInfo>) : void
        {
            this._fightspiritList = param1;
            return;
        }// end function

    }
}
