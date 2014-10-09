package com.game.dianjiangchun.message
{
    import com.game.dianjiangchun.bean.*;
    import net.*;

    public class SendDianjiangchunInfoToClientMessage extends Message
    {
        private var _stCurInfo:DianjiangchunInfo;

        public function SendDianjiangchunInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._stCurInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._stCurInfo = readBean(DianjiangchunInfo) as DianjiangchunInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 116101;
        }// end function

        public function get stCurInfo() : DianjiangchunInfo
        {
            return this._stCurInfo;
        }// end function

        public function set stCurInfo(param1:DianjiangchunInfo) : void
        {
            this._stCurInfo = param1;
            return;
        }// end function

    }
}
