package com.game.newactivity.bean
{
    import net.*;

    public class SimpleActivityInfo extends Bean
    {
        private var _activityId:int;
        private var _rewardNum:int;

        public function SimpleActivityInfo()
        {
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

        public function set rewardNum(param1:int) : void
        {
            this._rewardNum = param1;
            return;
        }// end function

        public function get rewardNum() : int
        {
            return this._rewardNum;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._activityId);
            writeInt(this._rewardNum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._activityId = readInt();
            this._rewardNum = readInt();
            return true;
        }// end function

    }
}
