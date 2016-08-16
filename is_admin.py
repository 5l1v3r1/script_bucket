def is_admin(): # works in Windows only
    import os
    try:
        result = os.listdir("C:\Windows\Temp")
        print("Welcome!")
        pass
    except:
        print("Please run this program as admin!")
        pass

def update():
    pass

# check if we have admin priv
is_admin()

# download ss+ / update it if necessary
update()

# install as system service
service()

# generate config, etc