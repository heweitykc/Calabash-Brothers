package com.game.map.message
{
    import com.game.map.bean.*;
    import net.*;

    public class ResRoundEffectMessage extends Message
    {
        private var _Effect:EffectInfo;

        public function ResRoundEffectMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._Effect);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._Effect = readBean(EffectInfo) as EffectInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101131;
        }// end function

        public function get Effect() : EffectInfo
        {
            return this._Effect;
        }// end function

        public function set Effect(param1:EffectInfo) : void
        {
            this._Effect = param1;
            return;
        }// end function

    }
}
