import numpy as np
import os
import matplotlib.pyplot as plt

data_dir = '../data/'
fig_dir = '../figs/'
os.makedirs(fig_dir,exist_ok=True)


f = open(data_dir+'nd.dac','r')
nd = int(f.read().split()[0])
f.close()

f = open(data_dir+'params.dac','r')
params = f.read().split()
f.close()

nx = int(params[0])
xmax = float(params[1])
xmin = float(params[2])

dx = (xmax - xmin)/nx
x = np.linspace(xmin + 0.5*dx, xmax - 0.5*dx,nx)

endian = '<'

plt.clf()
fig = plt.figure(num=100,figsize=(6,3))

xm = 0.5*(xmax + xmin)
dd = 0.04
for n in range(0,nd+1):
    print(n)
    f = open(data_dir+'t.dac.'+'{0:08d}'.format(n),"rb")
    t = np.fromfile(f,endian+'d',1)
    f.close()
    t = t.reshape(1,order='F')[0]

    gc = xm + t 
    qqc = np.exp(-((x-gc)/dd)**2)   + np.exp(-((x-gc+xmax)/dd)**2) 

    dtype = np.dtype([("qq",endian+str(nx)+"d")])
    f = open(data_dir+'qq.dac.'+'{0:08d}'.format(n),"rb")
    qq = np.fromfile(f,dtype=dtype,count=1)
    qq = qq["qq"].reshape(nx,order='F')

    ax = fig.add_subplot(111)
    ax.plot(x,qq,'.-')
    ax.plot(x,qqc,color='red')
    ax.set_xlim(0.,1)
    ax.set_ylim(-0.2,1.2)
    plt.pause(0.01)

    if(n == 0):
        fig.tight_layout()
    fig.savefig(fig_dir+'py'+'{0:04d}'.format(n)+'.png')

    if(n != nd):
        plt.clf()

        
