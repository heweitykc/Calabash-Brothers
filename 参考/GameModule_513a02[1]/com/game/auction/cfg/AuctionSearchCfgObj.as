package com.game.auction.cfg
{
    import com.f1.manager.*;

    public class AuctionSearchCfgObj extends Object
    {
        private var _map:Object;
        private var _ids:Array;
        private static var _inst:AuctionSearchCfgObj;

        public function AuctionSearchCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_hot_word");
            this._ids = new Array();
            this.parse();
            return;
        }// end function

        public function parse() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            for (_loc_1 in this._map)
            {
                
                _loc_2 = new Object();
                _loc_3 = _loc_10[_loc_1].q_input_word;
                _loc_4 = _loc_3.split(";");
                _loc_2.keys = _loc_4;
                _loc_5 = _loc_10[_loc_1].q_hot_word;
                _loc_6 = _loc_5.split(";");
                _loc_7 = new Array();
                _loc_8 = 0;
                while (_loc_8 < _loc_6.length)
                {
                    
                    _loc_7.push({label:_loc_6[_loc_8]});
                    _loc_8++;
                }
                _loc_2.valueArr = _loc_7;
                this._ids.push(_loc_2);
            }
            return;
        }// end function

        public function getRelateArr(param1:String) : Array
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = this._ids.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._ids[_loc_3].keys.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    if (param1 == this._ids[_loc_3].keys[_loc_5])
                    {
                        return this._ids[_loc_3].valueArr;
                    }
                    _loc_5++;
                }
                _loc_3++;
            }
            return null;
        }// end function

        public static function getInstance() : AuctionSearchCfgObj
        {
            var _loc_1:* = new AuctionSearchCfgObj;
            _inst = new AuctionSearchCfgObj;
            return _inst || _loc_1;
        }// end function

    }
}
