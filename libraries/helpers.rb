#
# Cookbook Name:: consul_agent
#
# Copyright 2016 Brian Clark
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module ConsulAgent
  module Helpers
    def checksums
      {
        'consul_0.5.0_darwin_amd64.zip' => '24d9758c873e9124e0ce266f118078f87ba8d8363ab16c2e59a3cd197b77e964',
        'consul_0.5.0_linux_386.zip' => '4b6147c30596a30361d4753d409f8a1af9518f54f5ed473a4c4ac973738ac0fd',
        'consul_0.5.0_linux_amd64.zip' => '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088',
        'consul_0.5.0_web_ui.zip' => '0081d08be9c0b1172939e92af5a7cf9ba4f90e54fae24a353299503b24bb8be9',
        'consul_0.5.0_windows_386.zip' => '7fd760ee8a5c2756391cacc1e924ae602b16cdad838db068e564f798383ad714',
        'consul_0.5.1_darwin_amd64.zip' => '06fef2ffc5a8ad8883213227efae5d1e0aa4192ccb772ec6086103a7a08fadf8',
        'consul_0.5.1_linux_386.zip' => 'dad93a02c01de885daee191bcc5a05ca2bf106200da61db33694a658432d8399',
        'consul_0.5.1_linux_amd64.zip' => '967ad75865b950698833eaf26415ba48d8a22befb5d4e8c77630ad70f251b100',
        'consul_0.5.1_web_ui.zip' => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1',
        'consul_0.5.1_windows_386.zip' => 'bb9e1753cf793ad6f9db34bd6e18fb0fa5b0696a8a51a7f1c61484386dfe6682',
        'consul_0.5.2_darwin_amd64.zip' => '87be515d7dbab760a61a359626a734f738d46ece367f68422b7dec9197d9eeea',
        'consul_0.5.2_linux_386.zip' => '29306ce398109f954ceeea3af79878be4fb0d949f8af3a27c95ccef2101e8f60',
        'consul_0.5.2_linux_amd64.zip' => '171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445',
        'consul_0.5.2_web_ui.zip' => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1',
        'consul_0.5.2_windows_386.zip' => '2e866812de16f1a6138a0fd1eebc76143f1314826e3b52597a55ac510ae94be6',
        'consul_0.6.0_darwin_386.zip' => '95d57bfcc287bc344ec3ae8372cf735651af1158c5b1345e6f30cd9a9c811815',
        'consul_0.6.0_darwin_amd64.zip' => '29ddff01368458048731afa586cec5426c8033a914b43fc83d6442e0a522c114',
        'consul_0.6.0_freebsd_386.zip' => 'c5eb9f5c211612148e1e1cd101670fd08fd1abf9b2e541ac2936ab9637626249',
        'consul_0.6.0_freebsd_amd64.zip' => 'd7be5c95b971f48ccbd2c53c342dced9a3d0a5bc58f57b4f2e75672d96929923',
        'consul_0.6.0_freebsd_arm.zip' => '92f29ad00f8f44d3be43b3b038a904c332757eb2a6848a7d6754583c2791e18b',
        'consul_0.6.0_linux_386.zip' => 'f58f3f03a8b48d89bb8be94a6d1767393ad2a410c920b064066e01c7fa24f06c',
        'consul_0.6.0_linux_amd64.zip' => '307fa26ae32cb8732aed2b3320ed8daf02c28b50d952cbaae8faf67c79f78847',
        'consul_0.6.0_linux_arm.zip' => '425e7332789deb446a486ac25f7143aba5f16453ac46ede39b71ab6a361d8726',
        'consul_0.6.0_web_ui.zip' => '73c5e7ee50bb4a2efe56331d330e6d7dbf46335599c028344ccc4031c0c32eb0',
        'consul_0.6.0_windows_386.zip' => '8379afd07668933c120880bba8228277e380abb14e07a6c45b94562ac19b37bd',
        'consul_0.6.0_windows_amd64.zip' => '182beea0d8d346a9bfd70679621a5542aeeeea1f35be81fa3d3aeec2479bac3d',
        'consul_0.6.1_darwin_386.zip' => '41dfcc0aefe0a60bdde413eaa8a4a0c98e396d6b438494f1cf29b32d07759b8e',
        'consul_0.6.1_darwin_amd64.zip' => '358654900772b3477497f4a5b5a841f2763dc3062bf29212606a97f5a7a675f3',
        'consul_0.6.1_freebsd_386.zip' => '87d8c56c0c02e2fcde5192614dff9c491af93f7186fd55caae3fbe2c4d6ca80c',
        'consul_0.6.1_freebsd_amd64.zip' => '04688dfabedf6ded7f3d548110c7d9ffc8d6d3a091062593e421702bc42b465d',
        'consul_0.6.1_freebsd_arm.zip' => '7b907fbd4377671de1be2dc0c19f955e1b37cd862c1af8251e9bf6d668b0d3a8',
        'consul_0.6.1_linux_386.zip' => '34b8d4a2a9ec85082b6e93c6785ba9c54663fec414062e45dd4386db46a533c4',
        'consul_0.6.1_linux_amd64.zip' => 'dbb3c348fdb7cdfc03e5617956b243c594a399733afee323e69ef664cdadb1ac',
        'consul_0.6.1_linux_arm.zip' => '5b61e9ed10e02990aa8a2a0116c398c61608bc7f5051cb5a13750ffd47a54d51',
        'consul_0.6.1_solaris_amd64.zip' => '54091eda692abdbca5e2fa58378c7a50f8bc86e20af782bd46165546bef816a9',
        'consul_0.6.1_web_ui.zip' => 'afccdd540b166b778c7c0483becc5e282bbbb1ee52335bfe94bf757df8c55efc',
        'consul_0.6.1_windows_386.zip' => '10197d1f7be0d0087414c9965008ddd88e9fcd9ac9d5bd02d72d65eda36f5834',
        'consul_0.6.1_windows_amd64.zip' => '2be6b0f0fdebff00aea202e9846131af570676f52e2936728cbf29ffbb02f57f',
        'consul_0.6.2_darwin_386.zip' => '973105816261c8001fcfa76c9fb707fa56325460476fb0daa97b9ece0602a918',
        'consul_0.6.2_darwin_amd64.zip' => '3089f77fcdb922894456ea6d0bc78a2fb60984d1d3687fa9d8f604b266c83446',
        'consul_0.6.2_freebsd_386.zip' => 'fc87f2ddd2090031e79136954d9e3f85db480d5ed9eba6ae627bf460e4c95e6e',
        'consul_0.6.2_freebsd_amd64.zip' => '1ccf96cb58c6fa927ee21c24d9be368ebe91559ed32626a89a715a3781659e3f',
        'consul_0.6.2_freebsd_arm.zip' => '30d8d09dd88cdd8d5256cea445fd0fed787d73cc6585e2eef7212161f29c8053',
        'consul_0.6.2_linux_386.zip' => '500ac8c75768b7f2d63521d2501ff8cc5fb7f9ddf6c550e9449364810c96f419',
        'consul_0.6.2_linux_amd64.zip' => '7234eba9a6d1ce169ff8d7af91733e63d8fc82193d52d1b10979d8be5c959095',
        'consul_0.6.2_linux_arm.zip' => 'b6b4f66f6dd8b1d4ebbd0339f4ed78c4853c7bd0d42fd15af70179b5bc65482e',
        'consul_0.6.2_solaris_amd64.zip' => 'f5655f0b173e5d51c5b92327d1fc7f24ac0939897a1966da09146e4eb75af9d1',
        'consul_0.6.2_web_ui.zip' => 'f144377b8078df5a3f05918d167a52123089fc47b12fc978e6fb375ae93afc90',
        'consul_0.6.2_windows_386.zip' => 'f072d89c098dde143897e653d5adaf23125b58062344ef4be4029d635f959654',
        'consul_0.6.2_windows_amd64.zip' => 'df3234fb7def7138b7cb8c73fe7c05942ec1e485925701a7b38fc7e2396a212f',
        'consul_0.6.3_darwin_386.zip' => '7fb30756504cd9559c9b23e5d0d8d73a847ee62ed85d39955b5906c2f59a5bc1',
        'consul_0.6.3_darwin_amd64.zip' => '6dff4ffc61d66aacd627a176737b8725624718a9e68cc81460a3df9b241c7932',
        'consul_0.6.3_freebsd_386.zip' => '4a1aa8f570852eb238b7406172c097f5b32f41a3f01186111e576faa7506248c',
        'consul_0.6.3_freebsd_amd64.zip' => '8bdf2da41e6118af18af9aba0a127d4abb3453a20a9064e1bd1206f5c11ac2c8',
        'consul_0.6.3_freebsd_arm.zip' => '5452d29f1cf0720c4ae0e0ec1cc5e44b0068a0340a6b61ab5ec245fa0f3447ad',
        'consul_0.6.3_linux_386.zip' => '2afb65383ab913344daaa9af827c1e8576c7cae16e93798048122929b6e4cc92',
        'consul_0.6.3_linux_amd64.zip' => 'b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250',
        'consul_0.6.3_linux_arm.zip' => 'c5fd5278be2757d2468bc7e263af15bc9a9e80fc5108fec658755804ea9bca56',
        'consul_0.6.3_solaris_amd64.zip' => 'e6a286ff17a2345b8800732850eadb858b3dba9486355e1164a774ccec2f0e98',
        'consul_0.6.3_web_ui.zip' => '93bbb300cacfe8de90fb3bd5ede7d37ae6ce014898edc520b9c96a676b2bbb72',
        'consul_0.6.3_windows_386.zip' => '55733a730c5055d0ed1dc2656b2b6a27b21c7c361a907919cfae90aab2dff870',
        'consul_0.6.3_windows_amd64.zip' => '04cd1fdc9cd3a27ffc64e312e40142db7af0d240608f8080ec6d238294b20652',
        'consul_0.6.4_darwin_386.zip' => '4cd39e968ca6bed0888f831a2fc438ffe0b48dab863c822e777f5b5219bacf5c',
        'consul_0.6.4_darwin_amd64.zip' => '75422bbd26107cfc5dfa7bbb65c1d8540a5193796b5c6b272d8d70b094b26488',
        'consul_0.6.4_freebsd_386.zip' => 'c2d0f7d5f785a83eeb962209a35ebb577b41c7f8cb1f78bf68a42e8f8be77d22',
        'consul_0.6.4_freebsd_amd64.zip' => 'fe0b04a2111c6274e79cc86a91b48cb63879f0badd4d6dc848cb7105a572c7fd',
        'consul_0.6.4_freebsd_arm.zip' => 'edf3862e3fef6a48ede1d2671fe6b8da8891ca57bd5381b8a19d8d1b68e4d5da',
        'consul_0.6.4_linux_386.zip' => 'dbaf5ad1c95aa7dce1625d61b6686d3775e53cb3e7d6c426d29ea96622d248a8',
        'consul_0.6.4_linux_amd64.zip' => 'abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627',
        'consul_0.6.4_linux_arm.zip' => '81200fc8b7965dfc6048c336925211eaf2c7247be5d050946a5dd4d53ec9817e',
        'consul_0.6.4_solaris_amd64.zip' => 'c26a64310f83c3ba388c78d5b89d640d961ae9eabe221c244bfffcfa753966bd',
        'consul_0.6.4_web_ui.zip' => '5f8841b51e0e3e2eb1f1dc66a47310ae42b0448e77df14c83bb49e0e0d5fa4b7',
        'consul_0.6.4_windows_386.zip' => '6555f0fff6c3f9ea310c94a73365d9892afc255efb47c85041ad1c0ede854b87',
        'consul_0.6.4_windows_amd64.zip' => '1ca3cc2943b27ec8968665efce1122d4ea355ccbde5b4807753af71f11190a9b',
        'consul_0.7.0_darwin_386.zip' => '16ab91969c9b268ccae532070221b6c4fecaad298e4662a46cdfe9847c80dd3f',
        'consul_0.7.0_darwin_amd64.zip' => '74111674527c5be0db7a98600df8290395abdd94e2cd86bda7418d748413396d',
        'consul_0.7.0_freebsd_386.zip' => 'fe7f80ce8fcdd517f4228b66a4836119ad6e22c2a5285cf4de02c0ccf8c2eefd',
        'consul_0.7.0_freebsd_amd64.zip' => '54c864ce0deeeb01d10752a787c3bc3154d6fb020859fcc8b089ac3548756702',
        'consul_0.7.0_freebsd_arm.zip' => '1b16624f3581a7bef5328d17ff4ab9188ffdd07543cab3fb72b3cd7a7d469724',
        'consul_0.7.0_linux_386.zip' => 'babf618b1f10455b4ab65b91bdf5d5a7be5bfbb874ce41e8051caca884c43378',
        'consul_0.7.0_linux_amd64.zip' => 'b350591af10d7d23514ebaa0565638539900cdb3aaa048f077217c4c46653dd8',
        'consul_0.7.0_linux_arm.zip' => '7c9ee149d66d14cc8aa81b8d86e7df5a27876216578ab841ab3921e7f4a0ce4b',
        'consul_0.7.0_solaris_amd64.zip' => '0f1db173a95861bc84940b4dcdb2debfbfbc18f2b50e651d0e23dfda331018ea',
        'consul_0.7.0_web_ui.zip' => '42212089c228a73a0881a5835079c8df58a4f31b5060a3b4ffd4c2497abe3aa8',
        'consul_0.7.0_windows_386.zip' => 'd0ddfe7d1de9879f02b0d110e45bb74cd5028a2910bcac8b2629d0659367cd96',
        'consul_0.7.0_windows_amd64.zip' => 'ac5973a58dd9c6f52c784a7106a29adcf7c94015036538155b6c0ee7efc3a330'
      }
    end
  end
end

Chef::Resource.send(:include, ConsulAgent::Helpers)
