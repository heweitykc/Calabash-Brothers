package com.game.longyuan.message
{
    import com.game.longyuan.bean.*;
    import net.*;

    public class ResLongYuanOpenMessage extends Message
    {
        private var _zhenqi:int;
        private var _longyuaninfo:LongYuanInfo;

        public function ResLongYuanOpenMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zhenqi);
            writeBean(this._longyuaninfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zhenqi = readInt();
            this._longyuaninfo = readBean(LongYuanInfo) as LongYuanInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 115101;
        }// end function

        public function get zhenqi() : int
        {
            return this._zhenqi;
        }// end function

        public function set zhenqi(param1:int) : void
        {
            this._zhenqi = param1;
            return;
        }// end function

        public function get longyuaninfo() : LongYuanInfo
        {
            return this._longyuaninfo;
        }// end function

        public function set longyuaninfo(param1:LongYuanInfo) : void
        {
            this._longyuaninfo = param1;
            return;
        }// end function

    }
}
