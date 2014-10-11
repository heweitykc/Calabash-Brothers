package com.game.bank.cfg
{
    import com.f1.manager.*;

    public class BankRateCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:BankRateCfgObj;

        public function BankRateCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_bank_rate");
            return;
        }// end function

        public function get map() : Object
        {
            return this._map;
        }// end function

        public function getBankRateByLev(param1:String) : BankRateCfg
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new BankRateCfg();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public static function getInstance() : BankRateCfgObj
        {
            if (instance == null)
            {
                instance = new BankRateCfgObj;
            }
            return instance;
        }// end function

    }
}
