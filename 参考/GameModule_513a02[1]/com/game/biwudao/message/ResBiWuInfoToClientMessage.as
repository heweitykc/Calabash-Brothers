package com.game.biwudao.message
{
    import com.game.biwudao.bean.*;
    import net.*;

    public class ResBiWuInfoToClientMessage extends Message
    {
        private var _biWuInfo:BiWuInfo;

        public function ResBiWuInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._biWuInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._biWuInfo = readBean(BiWuInfo) as BiWuInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 157101;
        }// end function

        public function get biWuInfo() : BiWuInfo
        {
            return this._biWuInfo;
        }// end function

        public function set biWuInfo(param1:BiWuInfo) : void
        {
            this._biWuInfo = param1;
            return;
        }// end function

    }
}
