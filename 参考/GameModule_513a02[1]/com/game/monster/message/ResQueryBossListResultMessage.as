package com.game.monster.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResQueryBossListResultMessage extends Message
    {
        private var _monsterModelId:Vector.<int>;

        public function ResQueryBossListResultMessage()
        {
            this._monsterModelId = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._monsterModelId.length);
            _loc_1 = 0;
            while (_loc_1 < this._monsterModelId.length)
            {
                
                writeInt(this._monsterModelId[_loc_1]);
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
                
                this._monsterModelId[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 114112;
        }// end function

        public function get monsterModelId() : Vector.<int>
        {
            return this._monsterModelId;
        }// end function

        public function set monsterModelId(param1:Vector.<int>) : void
        {
            this._monsterModelId = param1;
            return;
        }// end function

    }
}
