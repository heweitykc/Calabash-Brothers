package com.game.cloudbuy.message
{
    import net.*;

    public class ResLoginCloudBuyInfoToClientMessage extends Message
    {
        private var _cloudBuyID:int;
        private var _rewardCount:int;

        public function ResLoginCloudBuyInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._cloudBuyID);
            writeInt(this._rewardCount);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._cloudBuyID = readInt();
            this._rewardCount = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529115;
        }// end function

        public function get cloudBuyID() : int
        {
            return this._cloudBuyID;
        }// end function

        public function set cloudBuyID(param1:int) : void
        {
            this._cloudBuyID = param1;
            return;
        }// end function

        public function get rewardCount() : int
        {
            return this._rewardCount;
        }// end function

        public function set rewardCount(param1:int) : void
        {
            this._rewardCount = param1;
            return;
        }// end function

    }
}
