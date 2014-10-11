package com.game.elementHeart.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.elementHeart.model.*;
    import com.game.elementHeart.protocol.*;
    import com.game.elementHeart.view.*;
    import com.game.masterequip.bean.*;
    import com.game.masterequip.message.*;
    import com.model.vo.*;
    import com.util.*;

    public class ElementHeartControl extends Object
    {
        private var _elementHeartView:ElementHeartView;
        private var _elementHousePanel:ElementHousePanel;
        private var _protocol:ElementHeartProtocol;
        private var _dataInfo:ElementHeartData;
        private static var _instance:ElementHeartControl;
        public static const LANG:String = "lang_elementHeart";

        public function ElementHeartControl()
        {
            this._dataInfo = ElementHeartData.getInstance();
            this._protocol = new ElementHeartProtocol();
            return;
        }// end function

        public function initElementHeartView() : ElementHeartView
        {
            if (!this._elementHeartView)
            {
                this._elementHeartView = new ElementHeartView();
            }
            return this._elementHeartView;
        }// end function

        public function get elementHeartView() : ElementHeartView
        {
            return this._elementHeartView;
        }// end function

        public function openElementHousePanel() : void
        {
            if (!this._elementHousePanel)
            {
                this._elementHousePanel = new ElementHousePanel();
                Global.popManager.addPop(this._elementHousePanel);
            }
            this._elementHousePanel.open();
            return;
        }// end function

        public function closeElementHousePanel() : void
        {
            if (this._elementHousePanel)
            {
                this._elementHousePanel.close();
            }
            return;
        }// end function

        public function openOrCloseElementHousePanel() : void
        {
            if (!this._elementHousePanel)
            {
                this._elementHousePanel = new ElementHousePanel();
                Global.popManager.addPop(this._elementHousePanel);
            }
            this._elementHousePanel.openOrClose();
            return;
        }// end function

        public function resEheartInfo(param1:int, param2:Vector.<EheartInfo>) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = new Vector.<ElementHeartInfo>;
            for each (_loc_4 in param2)
            {
                
                _loc_3.push(PropUtil.createElementHeart(_loc_4));
            }
            this._dataInfo.update(_loc_3, param1);
            return;
        }// end function

        public function resAdd(param1:ResAddMessage) : void
        {
            var _loc_2:* = PropUtil.createElementHeartById(param1.modelId);
            _loc_2.index = param1.index;
            _loc_2.lock = param1.lock;
            _loc_2.exp = param1.exp;
            _loc_2.eheartId = param1.eheartId;
            this._dataInfo.add(_loc_2, param1.type);
            return;
        }// end function

        public function updateLock(param1:ResLockMessage) : void
        {
            this._dataInfo.updateLock(param1.type, param1.index, param1.lock);
            return;
        }// end function

        public function resRemove(param1:int, param2:int) : void
        {
            this._dataInfo.remove(param2, param1);
            return;
        }// end function

        public function resUpdate(param1:ResUpdateMessage) : void
        {
            this._dataInfo.updateItem(param1.type, param1.index, param1.exp, param1.level);
            return;
        }// end function

        public function reqContainer(param1:int) : void
        {
            this._protocol.reqContainer(param1);
            return;
        }// end function

        public function reqAutoSwallow(param1:int) : void
        {
            var tips:String;
            var type:* = param1;
            var max:* = ElementHeartData.MAX_LEVEL;
            var arr:* = this._dataInfo.getSwallower(type);
            var swallow:* = arr[0];
            var allExp:* = arr[1];
            var nextLevel:* = arr[2];
            if (!swallow || allExp == 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("eh1023", LANG));
            }
            else
            {
                tips = "<font color=\'#" + swallow.color + "\'>[" + swallow.q_name + "]</font>";
                if (!nextLevel)
                {
                    tips = LanguageCfgObj.getInstance().getByIndex("eh1019", LANG) + "<br/>" + tips;
                }
                if (!nextLevel && swallow.q_level <= max)
                {
                    tips = tips + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1018", LANG), [allExp, max]);
                }
                else if (nextLevel && nextLevel.q_level > swallow.q_level)
                {
                    tips = tips + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1018", LANG), [allExp, nextLevel.q_level]);
                }
                else
                {
                    tips = tips + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1017", LANG), [allExp]);
                }
                Global.popManager.cue(tips, null, null, function () : void
            {
                _protocol.reqAutoSwallow(type);
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function reqGainAll() : void
        {
            this._protocol.reqGainAll();
            return;
        }// end function

        public function reqGainOne(param1:int) : void
        {
            this._protocol.reqGainOne(param1);
            return;
        }// end function

        public function reqLock(param1:int, param2:int) : void
        {
            this._protocol.reqLock(param1, param2);
            return;
        }// end function

        public function reqChangeIndex(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._protocol.reqChangeIndex(param1, param2, param3, param4);
            return;
        }// end function

        public function reqSwallow(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._protocol.reqSwallowMessage(param1, param2, param3, param4);
            return;
        }// end function

        public function reqRemveEheart(param1:int, param2:int) : void
        {
            this._protocol.reqRemveEheart(param1, param2);
            return;
        }// end function

        public static function getInstance() : ElementHeartControl
        {
            if (!_instance)
            {
                _instance = new ElementHeartControl;
            }
            return _instance;
        }// end function

    }
}
