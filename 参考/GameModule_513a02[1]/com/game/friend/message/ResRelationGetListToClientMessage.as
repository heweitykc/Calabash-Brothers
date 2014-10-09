package com.game.friend.message
{
    import __AS3__.vec.*;
    import com.game.friend.bean.*;
    import net.*;

    public class ResRelationGetListToClientMessage extends Message
    {
        private var _relationMyInfo:RelationInfo;
        private var _relationList:Vector.<RelationInfo>;

        public function ResRelationGetListToClientMessage()
        {
            this._relationList = new Vector.<RelationInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeBean(this._relationMyInfo);
            writeShort(this._relationList.length);
            _loc_1 = 0;
            while (_loc_1 < this._relationList.length)
            {
                
                writeBean(this._relationList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._relationMyInfo = readBean(RelationInfo) as RelationInfo;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._relationList[_loc_1] = readBean(RelationInfo) as RelationInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 119101;
        }// end function

        public function get relationMyInfo() : RelationInfo
        {
            return this._relationMyInfo;
        }// end function

        public function set relationMyInfo(param1:RelationInfo) : void
        {
            this._relationMyInfo = param1;
            return;
        }// end function

        public function get relationList() : Vector.<RelationInfo>
        {
            return this._relationList;
        }// end function

        public function set relationList(param1:Vector.<RelationInfo>) : void
        {
            this._relationList = param1;
            return;
        }// end function

    }
}
