
# 数字图像处理期末复习
## 第一章
* 把物理世界表示到计算机中来是数字图像获取的关键
* 采样：用有限的样本数目去近似无限的现实物理信号，有限近似无限
* 量化：用离散计算机表示去近似连续的现实物理信号，离散近似连续
* 图像采样量化：图像有 $M*N$ 个像素，每个像素有$Q$个灰度级别。$M,N,Q$ 通常取2的整数次幂。若 $Q=2^b$,称为图像的8bit量化，或256灰度级，$b$ 越大图像失真越小
  * 对于人眼应用 $b$ 取5到8；对于卫星图片等分析应用 $b$ 取8到12
* 有大量细节的图像，需要量化的级数较少
* 最佳量化：使量化误差最小的量化方法，使用均方误差讨论最佳量化

## 第二章
* 灰度变换：领域大小为1的空间滤波，灰度变换函数 $s=T(r)$
* 灰度变换三类基本函数
  * 线性函数，如图像反转 $s=L-1-r, L=2^b$
  * 对数变换：$s=c*log(1+r)$ ，低灰度值拉伸，高灰度值压缩
  * 幂律变换（伽马变换）：$s=c*r^\gamma$ ，低灰度值压缩，高灰度值拉伸
* 灰度直方图：图像中每种灰度级的像素个数。横坐标是灰度级，纵坐标表示该灰度级出现的频率
* 阈值面积函数：连续图像中具有灰度级 $\geqslant D$的轮廓线所包围的面积
* 概率密度函数（PDF）：归一化到单位面积的直方图
* 累计分布函数（CDF）：归一化后灰度级 $\geqslant D$的轮廓线所包围的面积
* 灰度直方图的应用：图像快速检测，分割前景背景，面积计算

## 第三章
* 直方图均衡化：通过灰度变换函数，将原图像直方图的分布均衡化的过程。直方图呈均匀分布时，对比度会有明显增强
* 直方图均衡的离散变换函数
  $$s_k=T(r_k)=(L-1)\sum_{j=0}^k p_r(r_j) = \frac{(L-1)}{MN} \sum_{j=0}^k n_j$$

## 第四章
* 空间相关：平移滤波器模板，计算每个位置之和
* 空间卷积：与相关相似，但滤波器要旋转180度，实际中未必严格区分
* 平滑线性滤波器：
  * 均值滤波器：先求和，再归一化。优点：降低噪声；缺点：边缘模糊
  * 加权线性滤波器：非均匀权重，降低模糊
* 统计排序滤波器：非线性滤波器，对滤波器覆盖的像素排序，用排序决定的值替代中心像素
  * 中值滤波器，最大值滤波器，最小值滤波器
* 锐化处理：突出灰度的过渡部分
* 数字图像的边缘类似斜坡，一阶导数产生较粗边缘。二阶导数产生两个有间距的边缘，在增强细节方面比一阶导数好
* 离散拉普拉斯算子
  $$\begin{matrix}
      0 & 1 & 0\\
      1 &-4 & 1\\
      0 & 1 & 0\\
  \end{matrix}$$
* 非锐化掩蔽：从原图像减去一副非锐化版本
  1. 模糊原图像
  2. 从原图像减去模糊图像，得到模板
  3. 将模板加到原图像
* 使用一阶导数对图像锐化：利用梯度的大小
  * 梯度：最大变化率的方向 
  $\nabla f = \begin{bmatrix} g_x\\g_y\end{bmatrix} = \begin{bmatrix} \partial f/\partial x\\ \partial f/\partial y\end{bmatrix}$
  * 梯度大小 $M(x,y)=\sqrt{g_x^2+g_y^2}$
* 算数操作增强：以像素对像素为基础在两幅或多幅图像间进行
  * 加法：
    * 多次曝光：将不同时间曝光照片进行叠加
    * 减少图像中的随机噪声
  * 减法：观察图像中的细微差别（指纹抽取）
  * 乘法：通常用来进行掩模运算
  * 除法：通常可用来归一化

## 第五章
* 仿射变换：包括了旋转、伸缩、平移、倾斜等变换
  $$x=t_{11}v+t_{21}u+t_{31}$$
  $$y=t_{12}v+t_{22}u+t_{32}$$
  * $t_{31}$和$t_{32}$刻画了平移量
  * $t_{11}$和$t_{22}$刻画了伸缩比例
  * $t_{12}$和$t_{21}$刻画了倾斜程度
  * 优点：保持共线性，保持距离比例
* 线性插值 $f(x)=(x_2-x)*f(x_1)+(x-x_1)*f(x_2)$

## 第六章 & 第七章
* 卷积定理：空间域卷积的傅里叶变换 $\leftrightarrow$ 傅里叶变换在频域内的乘积；空间域乘积的傅里叶变换 $\leftrightarrow$ 傅里叶变换在频域内的卷积
* 采样定理：如果以超过函数最高频率的两倍采样率来获得样本，连续的带限函数可以完美地从它的样本集来恢复
* 二维采样定理：如果一个二维带限连续函数在两个方向上均以大于最高频率的两倍采样率来获得样本，则该函数可以完美地从它的样本集来恢复

## 第八章
* 频域滤波器一般流程：
  1. 给定一副大小为$M\times N$的输入图像$f(x,y)$，选择填充参数$P,Q$，典型地选择$P=2M,Q=2N$
  2. 对$f(x,y)$添加必要数量的0,形成大小为$P\times Q$的填充后图像$f_p(x,y)$
  3. 用$(-1)^{x+y}$乘以$f_p(x,y)$移到其变换的中心
  4. 计算来自步骤3的图像的DFT，得到$F(u,v)$
  5. 生成一个实的、对称的滤波函数$H(u,v)$，其大小为$P \times Q$，中心在$(P/2,Q/2)$处，用阵列相乘形成乘积$G(u,v)=H(u,v)F(u,v)$
  6. 得到处理后的图像 $g_p(x,y)=\{real[\Im^{-1}[G(u,v)]]\}(-1)^{x+y}$
  7. 通过$g_p(x,y)$的左上象限提取$M\times N$区域，得到最终处理结果$g(x,y)$
* 低通滤波器：衰减高频而通过低频，模糊图像。低频对应图像中缓慢变换的灰度
  * 理想低通滤波器：低频完全保留，高频完全抑制
  * 巴特沃斯低通滤波器：$D(u,v)$为$(u,v)$到中心距离，$D_0$为截止频率
    $$H(u,v)=\frac{1}{1+[D(u,v)/D_0]^{2n}}$$
  * 高斯低通滤波器：
    $$H(u,v)=e^{-D^2(u,v)/2D_0^2}$$

## 第九章
  * 高通滤波器：衰减低频而通过高频，强化细节。高频对应图像中剧烈变化的灰度
    * 理想高通滤波器：低频完全抑制，高频完全保留
    * 巴特沃斯高通滤波器：
    $$H(u,v)=\frac{1}{1+[D_0/D(u,v)^{2n}}$$
    * 高斯高通滤波器
    $$H(u,v)=1-e^{-D^2(u,v)/2D_0^2}$$ 
* 频率域拉普拉斯算子
  * 拉普拉斯算子 
    $$\nabla^2f=\frac{\partial^2f}{\partial^2 x}+\frac{\partial^2f}{\partial^2 y}$$
  * 频域滤波器，$H(u,v)=-4\pi^2(u^2+v^2)$
  * 频域滤波器（中心化）：$H(u,v)=-4\pi^2D^2(u,v)$

## 第十章
* 图像复原：
  * 已预先制定的目标改善图像，客观
  * 对模糊图像去模糊
  * 利用退化现象的先验知识来恢复图像。建模退化过程，利用逆过程复原图像
* 图像增强：
  * 由人的主观感受来评判，主观
  * 对比度拉伸，增强
* 噪声来源：
  * 图像获取：环境条件，传感器质量
  * 图像传输：无线信号被干扰
* 刻画噪声：
  * 空间域与频率域特点。白噪声：傅里叶变化后为常数
  * 噪声是否和图像相关
* 噪声的空间表示：概率密度函数（PDF）
* 噪声类型：高斯噪声、瑞利噪声、爱尔兰（伽马）噪声、指数噪声、均匀噪声、脉冲（椒盐）噪声
* 周期噪声：通常由电力或机电干扰产生，噪声与空间位置有关，可以通过频率域滤波复原
* 统计排序滤波器：
  * 非线性滤波器：对滤波器覆盖的像素排序，用排序决定的值代替中心像素
  * 中值滤波器：良好的去噪能力，并且模糊较少。尤其适用于单级或双极脉冲信号
  * 最大值滤波器：寻找图像中的亮点，降低胡椒噪声
  * 最小值滤波器：寻找图像中的暗点，降低盐粒噪声
  * 中点滤波器：使用最大值和最小值的中点，结合了统计排序与求平均。适用于随机噪声（高斯噪声、均匀噪声）
  * $\alpha$截断的均值滤波：去掉灰度最低的$d/2$个像素和灰度最高的$d/2$个像素。适用于存在多种噪声的情况

## 第十一章 & 第十二章
* 三种彩色模型：RGB彩色模型（彩色显示器），CYM彩色模型（彩色打印机），HSI模型（符合人的认知）
* RGB模型：黑色在原点，白色在最远的叫，体对角线是灰色
* CYM模型：青色（C)，洋红（M），黄色（Y）。
  $$[C,M,Y]^T=[1,1,1]^T-[R,G,B]^T$$
* HSI模型：色调（H），饱和度（S），强度（I）
  * 强度轴为黑色与白色的连线（体对角线）
  * 色调：与红色轴的夹角。饱和度：与强度轴的距离
  
## 第十三章 & 第十四章
* 边缘检测的三个基本步骤
  * 导数对噪声敏感，为降噪对图像进行平滑处理。
  * 边缘点的检测，抽取所有的潜在边缘点
  * 边缘定位，选出真正的边缘点
* 梯度：最大变化率的方向 
  $\nabla f = \begin{bmatrix} g_x\\g_y\end{bmatrix} = \begin{bmatrix} \partial f/\partial x\\ \partial f/\partial y\end{bmatrix}$
  * 梯度大小 $M(x,y)=\sqrt{g_x^2+g_y^2}$
  * 梯度方向$\alpha(x,y)=tan^{-1}(g_y/g_x)$
  * 边缘的方向与梯度正交
* 普鲁伊特算子（y方向）
  $$\begin{matrix}
      -1 & -1 & -1\\
      0 & 0 & 0\\
      1 & 1 & 1\\
  \end{matrix}$$
* Sobel算子（y方向）
  $$\begin{matrix}
      -1 & -2 & -1\\
      0 & 0 & 0\\
      1 & 2 & 1\\
  \end{matrix}$$
* 理想边缘检测器
  * 灰度变化和图像尺度有关，需要用不同尺寸的算子
  * 灰度变化会影响导数。一阶导数出现波峰或波谷，二阶导数出现零交叉
  * 理想的检测器具备如下功能：
    * 能够近似一阶或二阶导数
    * 能够被调整以在不同尺寸上起作用。大的算子检测模糊边缘，小的检测细节
* Marr-Hildreth边缘检测器步骤
  * 用高斯低通滤波器平滑图像
  * 计算上述图像的拉普拉斯
  * 寻找上述结果的零交叉
* Canny边缘检测器优点：
  * 低错误率，没有伪响应
  * 边缘点很好的被定位，接近真实边缘
  * 单一的边缘点响应。对于每个真实边缘点，仅返回一个点
* Canny边缘检测器步骤：
  1. 高斯函数平滑输入图像
  2. 计算图像的梯度
  3. 非最大抑制：把梯度生成的粗边缘变细。根据梯度的方向（边缘方向）确定边缘方向
  4. 滞后阈值：检测边缘，减少伪边缘点。需设置一高一低两个阈值
  5. 连通性分析，连接边缘

## 第十五章
* $b$ 和 $b'$是两种不同表方式的比特数。压缩比 $C=b/b'$，相对数据冗余$R=1-1/C$。$C=10$即意味着有90%的冗余。
* 灰度图像中的三种冗余
  1. 编码冗余。灰度图像的8位编码往往是冗余的。采用固定长度编码普遍存在冗余，可采用变长编码  
  2. 空间和时间冗余：图像中紧邻点事空间相关的；视频中连续帧是时间相关的
  3. 不相关的信息：被视觉系统忽略的信息；与图形用途无关的信息
* 霍夫曼编码：单独对信源符号编码。是最短的编码
* 霍夫曼编码步骤：
  1. 简化信源。对符号的概率进行排序，合并低概率符号。重复这一过程，直到剩余两个符号
  2. 对简化后的信源编码。从最小信源开始，返回到原信源，为每个分支分配一个符号
* 霍夫曼编码的实现：1.构造霍夫曼编码；2.查表法
  * 瞬时性：每个编码独立解码
  * 唯一可解码：序列的解码方式唯一

## 第十六章
* 集合的补集：$A^c$
* 集合的反射 $\hat{B}=\{w|w=-b,$  for $b \in B \}$
* 集合的平移 $(B)_z=\{c|c=b+z,$ for $b \in B\}$
* 集合B对集合A的腐蚀
  $$A \ominus B = \{z|(B)_z\subseteq A\} $$
  $(B)_z$表示把$B$的原点平移到$z$。
* 集合B对集合A的膨胀（低通滤波器）
  $$A \oplus B = \{z|(\hat{B})_z \cap A \not = \empty \} $$
* 对偶性
  $$(A \ominus B)^c=A^c\oplus \hat{B}$$
  $$(A \oplus B)^c=A^c\ominus \hat{B}$$
* 开操作：平滑物体轮廓，断开窄的连接，消除细的突出
* 闭操作：平滑部分轮廓，熔合窄的间断和长沟壑，消除小空洞，填补轮廓中的缝隙
* 集合B对集合A的开操作：
  $$A\circ B = (A\ominus B)\oplus B $$
  先用B腐蚀A，再用B对结果进行膨胀。$A \circ B$ 是 $A$ 的子集
* 集合B对集合A的闭操作：
  $$A\bullet B = (A\oplus B)\ominus B $$
  先用B膨胀A，再用B对结果进行腐蚀。$A$ 是 $A\bullet B$ 的子集
* 对偶性：
  $$(A\bullet B )^c = (A^c \circ \hat{B})$$
  $$(A\circ B )^c = (A^c \bullet \hat{B})$$

## 第十七章
* 最小距离分类器：把原型定义为每个类的平均向量，利用欧氏距离判断远近
  * 使用场景：类别均值之间的间距大，类内之间的分散程度小
  * 实际应用未必满足上述条件
  * 解决方案：对数据进行预处理（特征选取，特征抽取）；控制数据的产生过程
* 贝叶斯分类器：最佳统计分类器
  * 把属于$\omega_i$的模式预测为属于$\omega_j$遭受损失$L_{ij}$
  * 能够最小化平均损失
  * 前提条件：
    * 每个类出现的概率已知
    * 每个类的概率密度已知。从数据中估计非常困难，通常假设密度函数为某种解析形式，然后从数据中估计函数参数
 