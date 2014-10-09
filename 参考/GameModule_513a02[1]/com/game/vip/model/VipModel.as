package com.game.vip.model
{
    import com.cfg.obj.*;
    import com.f1.manager.timer.*;
    import com.f1.utils.*;
    import com.game.mall.control.*;
    import com.game.vip.bean.*;
    import com.model.*;

    public class VipModel extends Object
    {
        private var _info:VipInfo;
        private var _count:int;
        private var _remain:int;
        public var isOpeningVip:Boolean;
        private static var _inst:VipModel;
        public static const BUFF_ACTIVITE_LEVEL:int = 4;

        public function VipModel()
        {
            return;
        }// end function

        public function get info() : VipInfo
        {
            return this._info;
        }// end function

        public function set info(param1:VipInfo) : void
        {
            this._info = param1;
            if (this._info.remain != this._remain)
            {
                this._remain = this._info.remain;
                if (this._info.remain > 0)
                {
                    this._count = this._info.remain - ToolKit.getServerTime() * 0.001;
                }
                else
                {
                    this._count = 0;
                }
                Ticker.killTimer(this.update);
                if (this._count > 0)
                {
                    Ticker.registerTimer(1, this.update, null, this._count);
                }
            }
            UserObj.getInstance().playerInfo.vipid = param1.level;
            if (VipCfgObj.getInstance().getVIPStore(this._info.level))
            {
                MallControl.getInstance().addVip();
            }
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._count - 1;
            _loc_1._count = _loc_2;
            return;
        }// end function

        public function getCount() : int
        {
            return this._count < 0 ? (0) : (this._count);
        }// end function

        public function cleanVip() : void
        {
            var _loc_1:* = 0;
            this._info.level = 0;
            UserObj.getInstance().playerInfo.vipid = _loc_1;
            MallControl.getInstance().addVip();
            return;
        }// end function

        public static function getInstance() : VipModel
        {
            var _loc_1:* = new VipModel;
            _inst = new VipModel;
            return _inst || _loc_1;
        }// end function

    }
}
