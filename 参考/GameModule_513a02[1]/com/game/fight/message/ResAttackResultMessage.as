package com.game.fight.message
{
    import __AS3__.vec.*;
    import com.game.fight.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResAttackResultMessage extends Message
    {
        private var _fightId:long;
        private var _state:AttackResultInfo;
        private var _fighterIds:Vector.<long>;

        public function ResAttackResultMessage()
        {
            this._fighterIds = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._fightId);
            writeBean(this._state);
            writeShort(this._fighterIds.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._fighterIds.length)
            {
                
                writeLong(this._fighterIds[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fightId = readLong();
            this._state = readBean(AttackResultInfo) as AttackResultInfo;
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._fighterIds[_loc_2] = readLong();
                _loc_2++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 102102;
        }// end function

        public function get fightId() : long
        {
            return this._fightId;
        }// end function

        public function set fightId(param1:long) : void
        {
            this._fightId = param1;
            return;
        }// end function

        public function get state() : AttackResultInfo
        {
            return this._state;
        }// end function

        public function set state(param1:AttackResultInfo) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get fighterIds() : Vector.<long>
        {
            return this._fighterIds;
        }// end function

        public function set fighterIds(param1:Vector.<long>) : void
        {
            this._fighterIds = param1;
            return;
        }// end function

    }
}
