BASEDIR	:= $(dir $(firstword $(MAKEFILE_LIST)))
VPATH	:= $(BASEDIR)

#---------------------------------------------------------------------------------
# TARGET is the name of the output
# SOURCES is a list of directories containing source code
# INCLUDES is a list of directories containing header files
#---------------------------------------------------------------------------------
TARGET		:=	fireplace
SOURCES		:=	src
INCLUDES	:=	

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------
CFLAGS		+=	$(INCLUDES)
CXXFLAGS	+=	$(CFLAGS)
LDFLAGS		+=	$(WUT_NEWLIB_LDFLAGS) $(WUT_STDCPP_LDFLAGS) $(WUT_DEVOPTAB_LDFLAGS) \
				-lSDL2_ttf -lfreetype -lpng -lSDL2_gfx -lSDL2_image -lSDL2 -ljpeg -lz -lzip \
				-lcoreinit -lvpad -lsysapp -lproc_ui -lgx2 -lgfd -lwhb

#---------------------------------------------------------------------------------
# get a list of objects
#---------------------------------------------------------------------------------
CFILES		:=	$(foreach dir,$(SOURCES),$(wildcard $(dir)/*.c))
CPPFILES	:=	$(foreach dir,$(SOURCES),$(wildcard $(dir)/*.cpp))
SFILES		:=	$(foreach dir,$(SOURCES),$(wildcard $(dir)/*.s))
OBJECTS		:=	$(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)

#---------------------------------------------------------------------------------
# objectives
#---------------------------------------------------------------------------------
$(TARGET).rpx: $(OBJECTS)

clean:
	rm -rf $(TARGET).rpx $(OBJECTS) $(OBJECTS:.o=.d)

#---------------------------------------------------------------------------------
# wut
#---------------------------------------------------------------------------------
include $(WUT_ROOT)/share/wut.mk

#---------------------------------------------------------------------------------
# portlibs
#---------------------------------------------------------------------------------
PORTLIBS	:=	$(DEVKITPRO)/portlibs/ppc
LDFLAGS		+=	-L$(PORTLIBS)/lib
CFLAGS		+=	-I$(PORTLIBS)/include -I$(PORTLIBS)/include/SDL2
CXXFLAGS	+=	-I$(PORTLIBS)/include -I$(PORTLIBS)/include/SDL2