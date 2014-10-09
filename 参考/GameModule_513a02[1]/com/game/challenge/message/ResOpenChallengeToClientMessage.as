package com.game.challenge.message
{
    import com.game.challenge.bean.*;
    import net.*;

    public class ResOpenChallengeToClientMessage extends Message
    {
        private var _challengeInfo:ChallengeInfo;

        public function ResOpenChallengeToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._challengeInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._challengeInfo = readBean(ChallengeInfo) as ChallengeInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 144101;
        }// end function

        public function get challengeInfo() : ChallengeInfo
        {
            return this._challengeInfo;
        }// end function

        public function set challengeInfo(param1:ChallengeInfo) : void
        {
            this._challengeInfo = param1;
            return;
        }// end function

    }
}
