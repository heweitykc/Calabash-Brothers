package com.game.backpack.control
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.player.model.*;
    import com.game.primaryrole.model.*;
    import com.game.toplist.control.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import interfaces.*;

    public class EquipCompareControl extends Object implements IEquiptipControl
    {
        private static var _info:PropInfo;
        private static var basetip:BaseTips;

        public function EquipCompareControl()
        {
            return;
        }// end function

        public function getEquip(param1:EquipmentInfo) : EquipmentInfo
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1.q_kind == Params.SHOW)
            {
                return null;
            }
            if (param1.q_kind == Params.LEFT_WEAPON || param1.q_kind == Params.RIGHT_WEAPON)
            {
                _loc_3 = EquipsObj.getInstance().getEquipBy(Params.LEFT_WEAPON);
                _loc_4 = EquipsObj.getInstance().getEquipBy(Params.RIGHT_WEAPON);
                if (param1.q_kind == Params.LEFT_WEAPON)
                {
                    if (_loc_3.fightNumber > 0)
                    {
                        return _loc_3;
                    }
                    if (_loc_4.fightNumber > 0 && _loc_4.q_kind == Params.RIGHT_WEAPON)
                    {
                        return _loc_4;
                    }
                }
                else if (param1.q_kind == Params.RIGHT_WEAPON)
                {
                    if (_loc_4.fightNumber > 0 && _loc_4.q_kind == Params.RIGHT_WEAPON)
                    {
                        return _loc_4;
                    }
                }
            }
            else if (param1.q_kind == Params.RING1)
            {
                _loc_5 = EquipsObj.getInstance().getEquipBy(Params.RING1);
                _loc_6 = EquipsObj.getInstance().getEquipBy(Params.RING2);
                if (_loc_5.fightNumber > 0)
                {
                    return _loc_5;
                }
                if (_loc_6.fightNumber > 0)
                {
                    return _loc_6;
                }
            }
            else
            {
                _loc_2 = EquipsObj.getInstance().getEquipBy(param1.q_kind);
                if (_loc_2.fightNumber > 0)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function isOtherEquip(param1:EquipmentInfo) : Boolean
        {
            var _loc_2:* = EquipsObj.getInstance().info;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.items.length)
            {
                
                if (!long.isZero(_loc_2.items[_loc_3].itemId) && _loc_2.items[_loc_3].itemId.equal(param1.itemId))
                {
                    return false;
                }
                _loc_3++;
            }
            return true;
        }// end function

        public function getSuitCount(param1:int, param2:int, param3:int) : int
        {
            return EquipsObj.getInstance().getSuitCount(param1, param2, param3);
        }// end function

        public function getOtherSuitCount(param1:int, param2:int, param3:int) : int
        {
            return EquipsObj.countSuitNumber(OtherEquipsData.getInstance().items, param1);
        }// end function

        public function getToplistSuitCount(param1:int, param2:int, param3:int) : int
        {
            return EquipsObj.countSuitNumber(TopListControl.getInstance().weaList, param1);
        }// end function

        public static function createEquipTips(param1:PropInfo, param2:Boolean = true) : BaseTips
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            if (_info)
            {
                if (param1 == _info)
                {
                    if (basetip)
                    {
                        removeTips(basetip);
                    }
                }
                else if (basetip && basetip.parent)
                {
                    return basetip;
                }
            }
            _info = param1;
            _loc_3 = PropUtil.getTips(param1);
            if (_loc_3 is PropTips)
            {
                _loc_3.repaint(param1);
                _loc_3.x = TipsUtil.getTipX(_loc_3);
                _loc_3.y = TipsUtil.getTipY(_loc_3);
            }
            else if (_loc_3 is EquipTips)
            {
                _loc_3.repaint(param1);
                _loc_4 = _loc_3 as EquipTips;
                _loc_5 = param1 as EquipmentInfo;
                if (_loc_5 && (_loc_5.pos == 0 || ItemTips.equipcompareControl.isOtherEquip(_loc_5)))
                {
                    _loc_6 = ItemTips.equipcompareControl.getEquip(_loc_5);
                    if (_loc_6)
                    {
                        _loc_7 = new EquipTips();
                        _loc_7.isvice = true;
                        _loc_7.repaint(_loc_6);
                        (_loc_4).compareTip = _loc_7;
                    }
                }
                if (_loc_4)
                {
                    if (_loc_4.compareTip == null)
                    {
                        _loc_4.x = TipsUtil.getEquipTipX(_loc_4.width, _loc_4.height);
                        _loc_4.y = TipsUtil.getTipY(_loc_4);
                    }
                    else
                    {
                        _loc_8 = _loc_3.width + _loc_4.compareTip.width + 3;
                        _loc_9 = Math.max(_loc_3.height, _loc_4.compareTip.height);
                        _loc_10 = TipsUtil.getEquipTipX(_loc_8, _loc_9);
                        _loc_11 = _loc_4.compareTip ? (_loc_4.compareTip.height) : (0);
                        _loc_12 = TipsUtil.getEquipTipY2(_loc_8, _loc_11, _loc_4.height);
                        if (_loc_10 > FrameworkGlobal.stage.mouseX)
                        {
                            _loc_4.x = _loc_10;
                            _loc_4.y = _loc_12;
                            _loc_4.compareTip.x = _loc_10 + _loc_4.width + 3;
                            _loc_4.compareTip.y = _loc_12;
                        }
                        else
                        {
                            _loc_4.x = _loc_10 + _loc_4.compareTip.width + 3;
                            _loc_4.y = _loc_12;
                            _loc_4.compareTip.x = _loc_10;
                            _loc_4.compareTip.y = _loc_12;
                        }
                        FrameworkGlobal.stage.addChild(_loc_4.compareTip);
                    }
                }
            }
            FrameworkGlobal.stage.addChild(_loc_3);
            if (param2)
            {
                FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, __stageClick, false, 0, true);
            }
            basetip = _loc_3;
            return _loc_3;
        }// end function

        public static function removeTips(param1:BaseTips) : void
        {
            if (param1 == basetip)
            {
                if (basetip && basetip.parent)
                {
                    basetip.parent.removeChild(basetip);
                    basetip = null;
                    FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, __stageClick, false, 0, true);
                }
            }
            return;
        }// end function

        private static function __stageClick(event:MouseEvent) : void
        {
            if (basetip && basetip.parent)
            {
                basetip.parent.removeChild(basetip);
                basetip = null;
                FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, __stageClick, false, 0, true);
            }
            return;
        }// end function

    }
}
