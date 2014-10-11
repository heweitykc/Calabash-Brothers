package com.model.vo
{
    import com.cfg.info.*;

    public class HorseInfo extends HorseTableVo
    {
        private var _currentExp:uint;
        private var _horseStat:uint;

        public function HorseInfo()
        {
            return;
        }// end function

        public function isRiding() : Boolean
        {
            return this._horseStat > 0;
        }// end function

        public function get currentExp() : uint
        {
            return this._currentExp;
        }// end function

        public function set currentExp(param1:uint) : void
        {
            this._currentExp = param1;
            return;
        }// end function

        public function get horseStat() : uint
        {
            return this._horseStat;
        }// end function

        public function set horseStat(param1:uint) : void
        {
            this._horseStat = param1;
            return;
        }// end function

    }
}
