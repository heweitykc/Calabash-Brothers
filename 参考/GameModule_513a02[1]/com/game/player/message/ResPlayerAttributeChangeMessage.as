package com.game.player.message
{
    import __AS3__.vec.*;
    import com.game.player.bean.*;
    import net.*;

    public class ResPlayerAttributeChangeMessage extends Message
    {
        private var _attributeChangeReason:int;
        private var _modelId:int;
        private var _attributeChangeList:Vector.<PlayerAttributeItem>;

        public function ResPlayerAttributeChangeMessage()
        {
            this._attributeChangeList = new Vector.<PlayerAttributeItem>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._attributeChangeReason);
            writeInt(this._modelId);
            writeShort(this._attributeChangeList.length);
            _loc_1 = 0;
            while (_loc_1 < this._attributeChangeList.length)
            {
                
                writeBean(this._attributeChangeList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._attributeChangeReason = readInt();
            this._modelId = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._attributeChangeList[_loc_1] = readBean(PlayerAttributeItem) as PlayerAttributeItem;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 103119;
        }// end function

        public function get attributeChangeReason() : int
        {
            return this._attributeChangeReason;
        }// end function

        public function set attributeChangeReason(param1:int) : void
        {
            this._attributeChangeReason = param1;
            return;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get attributeChangeList() : Vector.<PlayerAttributeItem>
        {
            return this._attributeChangeList;
        }// end function

        public function set attributeChangeList(param1:Vector.<PlayerAttributeItem>) : void
        {
            this._attributeChangeList = param1;
            return;
        }// end function

    }
}
