package com.game.guild.bean
{
    import com.game.utils.*;
    import net.*;

    public class ContributionInfo extends Bean
    {
        private var _userName:String;
        private var _dragonHistory:int;
        private var _whiteTigerHistory:int;
        private var _suzakuHistory:int;
        private var _basalticHistory:int;
        private var _stockGoldHistory:long;

        public function ContributionInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._userName);
            writeInt(this._dragonHistory);
            writeInt(this._whiteTigerHistory);
            writeInt(this._suzakuHistory);
            writeInt(this._basalticHistory);
            writeLong(this._stockGoldHistory);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._userName = readString();
            this._dragonHistory = readInt();
            this._whiteTigerHistory = readInt();
            this._suzakuHistory = readInt();
            this._basalticHistory = readInt();
            this._stockGoldHistory = readLong();
            return true;
        }// end function

        public function get userName() : String
        {
            return this._userName;
        }// end function

        public function set userName(param1:String) : void
        {
            this._userName = param1;
            return;
        }// end function

        public function get dragonHistory() : int
        {
            return this._dragonHistory;
        }// end function

        public function set dragonHistory(param1:int) : void
        {
            this._dragonHistory = param1;
            return;
        }// end function

        public function get whiteTigerHistory() : int
        {
            return this._whiteTigerHistory;
        }// end function

        public function set whiteTigerHistory(param1:int) : void
        {
            this._whiteTigerHistory = param1;
            return;
        }// end function

        public function get suzakuHistory() : int
        {
            return this._suzakuHistory;
        }// end function

        public function set suzakuHistory(param1:int) : void
        {
            this._suzakuHistory = param1;
            return;
        }// end function

        public function get basalticHistory() : int
        {
            return this._basalticHistory;
        }// end function

        public function set basalticHistory(param1:int) : void
        {
            this._basalticHistory = param1;
            return;
        }// end function

        public function get stockGoldHistory() : long
        {
            return this._stockGoldHistory;
        }// end function

        public function set stockGoldHistory(param1:long) : void
        {
            this._stockGoldHistory = param1;
            return;
        }// end function

    }
}
