package com.f1.interfaces.manager
{
    import com.f1.*;
    import com.f1.ui.*;

    public interface IUIManager
    {

        public function IUIManager();

        function addUI(param1:BaseSprite, param2:LayoutInfo = null, param3:uint = 0, param4:Boolean = false) : void;

        function removeUI(param1:BaseSprite) : void;

        function hideGroup(param1:uint) : void;

        function showGroup(param1:uint) : void;

        function layoutUI(param1:BaseSprite) : void;

        function get UIContainer() : BaseSprite;

    }
}
