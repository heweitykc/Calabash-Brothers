package com.game.awardGuide.control
{
    import com.cfg.obj.*;
    import com.game.awardGuide.view.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.guide.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;

    public class ItemAwardGuideControl extends BaseAwardGuideControl
    {
        private var _taskAwardId:int = 0;
        private var _panel:ItemAwardPanel;
        private static var _instance:ItemAwardGuideControl;

        public function ItemAwardGuideControl()
        {
            return;
        }// end function

        override public function removeGuide(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (guideList)
            {
                _loc_2 = 0;
                while (_loc_2 < guideList.length)
                {
                    
                    _loc_3 = guideList[_loc_2] as PropInfo;
                    if (_loc_3.itemModelId == param1.itemModelId)
                    {
                        guideList.splice(_loc_2, 1);
                        continue;
                    }
                    _loc_2++;
                }
                TweenLite.killDelayedCallsTo(this.checkNextGuide);
                TweenLite.delayedCall(0.1, this.checkNextGuide);
            }
            return;
        }// end function

        override protected function showGuide(param1:Object) : void
        {
            if (!this._panel)
            {
                this._panel = new ItemAwardPanel();
                this._panel.isGuideUseItemPanel = true;
            }
            this._panel.info = param1 as PropInfo;
            if (this._taskAwardId == param1.itemModelId)
            {
                this._panel.needArrowGuide = true;
            }
            this._panel.open();
            return;
        }// end function

        override protected function checkNeedGuide(param1:Object) : Boolean
        {
            var _loc_3:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo;
            if (param1.q_type == 6)
            {
                for each (_loc_3 in _loc_2.skillList)
                {
                    
                    if (_loc_3.q_skillID == param1.q_skill)
                    {
                        return false;
                    }
                }
            }
            return param1.q_auto_getuse && PropUtil.checkCanEquip(param1 as PropInfo, _loc_2);
        }// end function

        override protected function checkGuide(param1:Object) : Boolean
        {
            if ((!this._panel || !this._panel.isOpen) && (guideList.length == 0 || guideList[0].itemId.equal(param1.itemId)) && param1 != null)
            {
                return true;
            }
            return false;
        }// end function

        override protected function removeItem(event:BackpackEvent) : void
        {
            super.removeItem(event);
            var _loc_2:* = event.data as PropInfo;
            if (this._panel && this._panel.info && _loc_2.itemId.equal(this._panel.info.itemId))
            {
                this._panel.close();
            }
            return;
        }// end function

        private function checkNextGuide() : void
        {
            var _loc_1:* = null;
            if (this._panel && this._panel.isOpen)
            {
                return;
            }
            while (guideList && guideList.length > 0)
            {
                
                _loc_1 = guideList[0] as PropInfo;
                _loc_1 = BackpackObj.getInstance().getItemById(_loc_1.itemId);
                if (this.checkGuide(_loc_1))
                {
                    this.showGuide(_loc_1);
                    break;
                    continue;
                }
                guideList.splice(0, 1);
            }
            return;
        }// end function

        public function onDeleteCompleteTask(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (!TaskCfgObj.getInstance().getGuideConfigByTaskId(param1, 0, GuideConfigObj.getInstance().TASK_ITEM_AWARD_GUIDE_ID_1))
            {
                return;
            }
            var _loc_2:* = TaskCfgObj.getInstance().getTaskById(param1);
            var _loc_3:* = _loc_2.q_rewards_goods;
            if (_loc_3 && _loc_3 != "")
            {
                _loc_4 = _loc_3.split(";");
                _loc_8 = UserObj.getInstance().playerInfo;
                for each (_loc_5 in _loc_4)
                {
                    
                    _loc_6 = _loc_5.split("_");
                    _loc_7 = new PropInfo();
                    _loc_7.convByCfg(_loc_6[0]);
                    if (_loc_7.q_auto_getuse && PropUtil.checkCanEquip(_loc_7, _loc_8))
                    {
                        this._taskAwardId = _loc_7.itemModelId;
                        break;
                    }
                }
            }
            return;
        }// end function

        public static function getInstance() : ItemAwardGuideControl
        {
            var _loc_1:* = new ItemAwardGuideControl;
            _instance = new ItemAwardGuideControl;
            return _instance || _loc_1;
        }// end function

    }
}
