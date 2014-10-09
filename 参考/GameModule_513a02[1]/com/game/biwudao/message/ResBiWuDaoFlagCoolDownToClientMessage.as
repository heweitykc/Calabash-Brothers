package com.game.biwudao.message
{
    import net.*;

    public class ResBiWuDaoFlagCoolDownToClientMessage extends Message
    {
        private var _flagcooldown:int;

        public function ResBiWuDaoFlagCoolDownToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._flagcooldown);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._flagcooldown = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 157105;
        }// end function

        public function get flagcooldown() : int
        {
            return this._flagcooldown;
        }// end function

        public function set flagcooldown(param1:int) : void
        {
            this._flagcooldown = param1;
            return;
        }// end function

    }
}
