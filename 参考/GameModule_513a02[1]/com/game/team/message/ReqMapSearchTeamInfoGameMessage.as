package com.game.team.message
{
    import net.*;

    public class ReqMapSearchTeamInfoGameMessage extends Message
    {
        private var _searchcontent:String;

        public function ReqMapSearchTeamInfoGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._searchcontent);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._searchcontent = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118212;
        }// end function

        public function get searchcontent() : String
        {
            return this._searchcontent;
        }// end function

        public function set searchcontent(param1:String) : void
        {
            this._searchcontent = param1;
            return;
        }// end function

    }
}
