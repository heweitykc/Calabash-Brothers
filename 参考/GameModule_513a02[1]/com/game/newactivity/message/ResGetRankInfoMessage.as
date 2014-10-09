package com.game.newactivity.message
{
    import __AS3__.vec.*;
    import com.game.newactivity.bean.*;
    import net.*;

    public class ResGetRankInfoMessage extends Message
    {
        private var _activityId:int;
        private var _infoList:Vector.<SimpleRankInfo>;

        public function ResGetRankInfoMessage()
        {
            this._infoList = new Vector.<SimpleRankInfo>;
            return;
        }// end function

        public function set activityId(param1:int) : void
        {
            this._activityId = param1;
            return;
        }// end function

        public function get activityId() : int
        {
            return this._activityId;
        }// end function

        public function set infoList(param1:Vector.<SimpleRankInfo>) : void
        {
            this._infoList = param1;
            return;
        }// end function

        public function get infoList() : Vector.<SimpleRankInfo>
        {
            return this._infoList;
        }// end function

        override public function getId() : int
        {
            return 511007;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._activityId);
            writeShort(this._infoList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._infoList.length)
            {
                
                writeBean(this._infoList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._activityId = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._infoList[_loc_2] = readBean(SimpleRankInfo) as SimpleRankInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
