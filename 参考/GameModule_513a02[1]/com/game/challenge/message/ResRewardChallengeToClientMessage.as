package com.game.challenge.message
{
    import __AS3__.vec.*;
    import com.game.challenge.bean.*;
    import net.*;

    public class ResRewardChallengeToClientMessage extends Message
    {
        private var _rewardInfo:Vector.<ChallengeRewardInfo>;

        public function ResRewardChallengeToClientMessage()
        {
            this._rewardInfo = new Vector.<ChallengeRewardInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._rewardInfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._rewardInfo.length)
            {
                
                writeBean(this._rewardInfo[_loc_1]);
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
                
                this._rewardInfo[_loc_1] = readBean(ChallengeRewardInfo) as ChallengeRewardInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 144102;
        }// end function

        public function get rewardInfo() : Vector.<ChallengeRewardInfo>
        {
            return this._rewardInfo;
        }// end function

        public function set rewardInfo(param1:Vector.<ChallengeRewardInfo>) : void
        {
            this._rewardInfo = param1;
            return;
        }// end function

    }
}
