package com.game.longyuan.message
{
    import com.game.longyuan.bean.*;
    import net.*;

    public class ResLongYuanPosTipsMessage extends Message
    {
        private var _longyuanpostipsinfo:LongYuanPosTipsInfo;

        public function ResLongYuanPosTipsMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._longyuanpostipsinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._longyuanpostipsinfo = readBean(LongYuanPosTipsInfo) as LongYuanPosTipsInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 115103;
        }// end function

        public function get longyuanpostipsinfo() : LongYuanPosTipsInfo
        {
            return this._longyuanpostipsinfo;
        }// end function

        public function set longyuanpostipsinfo(param1:LongYuanPosTipsInfo) : void
        {
            this._longyuanpostipsinfo = param1;
            return;
        }// end function

    }
}
