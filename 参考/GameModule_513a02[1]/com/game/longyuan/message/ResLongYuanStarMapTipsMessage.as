package com.game.longyuan.message
{
    import com.game.longyuan.bean.*;
    import net.*;

    public class ResLongYuanStarMapTipsMessage extends Message
    {
        private var _starmaptipsinfo:LongYuanStarMapTipsInfo;

        public function ResLongYuanStarMapTipsMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._starmaptipsinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._starmaptipsinfo = readBean(LongYuanStarMapTipsInfo) as LongYuanStarMapTipsInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 115104;
        }// end function

        public function get starmaptipsinfo() : LongYuanStarMapTipsInfo
        {
            return this._starmaptipsinfo;
        }// end function

        public function set starmaptipsinfo(param1:LongYuanStarMapTipsInfo) : void
        {
            this._starmaptipsinfo = param1;
            return;
        }// end function

    }
}
