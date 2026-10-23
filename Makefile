#(WOW_PATH) # path to your local wow installation. The folder where wow.exe lives
TARGET := patch-O.mpq
SRC_PATCHES := $(WOW_PATH)/Data/patch.MPQ $(WOW_PATH)/Data/patch-1.mpq $(WOW_PATH)/Data/patch-2.mpq $(WOW_PATH)/Data/patch-3.mpq $(WOW_PATH)/Data/patch-4.mpq $(WOW_PATH)/Data/patch-5.mpq

$(TARGET): target/release/wow_dbc_patcher DBFilesClient/*.dbc
	./target/release/wow_dbc_patcher build  --dbc-dir DBFilesClient/ --mpq $(TARGET)

DBFilesClient/*.dbc: $(SRC_PATCHES)
	smpq --extract --overwrite $(WOW_PATH)/Data/dbc.MPQ \
		-p $(SRC_PATCHES) \
		-- '*.dbc'
	touch DBFilesClient/*.dbc

target/release/wow_dbc_patcher: $(wildcard src/*.rs) Cargo.toml
	cargo build --release

.PHONY: clean
clean:
	rm -rf DBFilesClient/
	rm -rf target/
	rm $(TARGET)
